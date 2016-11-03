<h2><?php echo __('Revisions&nbsp&nbsp&nbsp'); 
//$rootf = dirname(__FILE__);
$rootfarr = explode("/", DBV_ROOT_PATH);
array_pop($rootfarr);
$rootFolder = implode("/",$rootfarr);

$gitout = array();

$branch = trim(exec("git -C ".$rootFolder."/abacus branch",$gitout));
foreach ($gitout as $key => $value) {
	if ($value[0] == '*') {
		$branch = trim(substr($value,1));
		break;
	}
}
echo ' Branch: '.$branch;
?></h2>
<?php

if (isset($this->revisions) && count($this->revisions)) { ?>
	<form method="post" action="" class="nomargin" id="revisions">
		<div class="log"></div>

		<table class="table table-condensed table-striped table-bordered">
			<thead>
				<tr>
					<th style="width: 13px;"><input type="checkbox" style="margin-top: 0;" /></th>
					<th><?php echo __('Revision ID'); ?></th>
				</tr>
			</thead>
			<tbody>
				<?php

				$lastSavedT = json_decode(file_get_contents(DBV_REVISIONS_PATH.DS.DB_NAME."_lastsaved"),true);

				$lastSaved = is_null($lastSavedT)?array():$lastSavedT;

				foreach ($this->revisions as $revision) { 

						//$revLastSaved = array_key_exists($revision, $lastSaved);

						$rev_arr = explode("_", $revision);
						
						$revsName = array_map(function($a){
								$b = (array) $a;
								return $b['name'];
							}, $this->impRevs);

						if (in_array($revision, $revsName)) {
							$ran = true;
						}else{
							$ran = false;
						}
						
						if ($ran) {
							$class = 'ran';
						}

						$files = $this->_getRevisionFiles($revision);
					?>
					<tr data-revision="<?php echo $revision; ?>"<?php echo !is_null($class) ? ' class="' . $class . '"'  : ''; ?>>
						<td class="center">
							<input type="checkbox" name="revisions[]" value="<?php echo $revision; ?>"<?php echo $ran ? 'disabled ' : ' checked="checked"'; ?> style="margin-top: 7px;" />
						</td>
						<td>
							<h3 class="nomargin">
								<a href="javascript:" class="revision-handle"><?php echo $revision; ?></a>
							</h3>

							<?php if (count($files)) { ?>
								<div class="revision-files" style="display: none;">
									<?php $i = 0; 
										foreach ($files as $file) {
											$extension = pathinfo($file, PATHINFO_EXTENSION);
											$content = htmlentities($this->_getRevisionFileContents($revision, $file), ENT_QUOTES, 'UTF-8');
											$lines = substr_count($content, "\n");
										?>
										<div id="revision-file-<?php echo $revision; ?>-<?php echo ++$i; ?>">
											<div class="log"></div>
											<div class="alert alert-info heading">
												<?php 
												if (count($rev_arr) < 4) {
												?>

												<button data-role="editor-save" data-revision="<?php echo $revision; ?>" data-file="<?php echo $file; ?>" type="button" class="btn btn-mini btn-info pull-right" style="margin-top: -1px;" <?php if($ran){echo 'disabled';} ?> ><?php echo __('Save file') ?></button>

												<?php
												}
												?>
												<strong class="alert-heading"><?php echo $file; ?></strong>
											</div>
											<textarea data-role="editor" name="revision_files[<?php echo $revision; ?>][<?php echo $file; ?>]" rows="<?php echo $lines + 1; ?>"><?php echo $content; ?></textarea>
										</div>
									<?php } ?>
								</div>
							<?php } ?>
						</td>
					</tr>
				<?php } ?>
			</tbody>
		</table>
		<input type="submit" class="btn btn-primary" value="Run selected revisions" />
	</form>
<?php } else { ?>
	<div class="alert alert-info nomargin">
		<?php echo __('No revisions in #{path}', array('path' => '<strong>' . REVISIONS_PATH . '</strong>')) ?>
	</div>
<?php } ?>
<script type="text/javascript">
	document.observe('dom:loaded', function () {
		var form = $('revisions');
		if (!form) {
			return;
		}

		var textareas = form.select('textarea');
		textareas.each(function (textarea) {
			textarea['data-editor'] = CodeMirror.fromTextArea(textarea, {
				mode: "text/x-mysql",
				tabMode: "indent",
				matchBrackets: true,
				autoClearEmptyLines: true,
				lineNumbers: true,
				theme: 'default'
			});
		});

		$$('.revision-handle').invoke('observe', 'click', function (event) {
			var element = event.findElement('.revision-handle');
			var container = element.up('td').down('.revision-files');
			if (container) {
				container.toggle();
				if (!container.visible()) {
					return;
				}

				var textareas = container.select('textarea[data-role="editor"]');
				if (textareas) {
					textareas.each(function (textarea) {
						textarea['data-editor'].refresh();
					});
				}
			}
		});

		$$('button[data-role="editor-save"]').invoke('observe', 'click', function (event) {
			
			var self = this;

			var editor = this.up('.heading').next('textarea')['data-editor'];
			var container = this.up('[id^="revision-file"]');
			this.up('[class~="ran"]').checked = true;
			this.up('[class~="ran"]').removeClassName('ran');

			this.disable();

			clear_messages(container);

			new Ajax.Request('index.php?a=saveRevisionFile', {
				parameters: {
					revision: this.getAttribute('data-revision'),
					file: this.getAttribute('data-file'),
					content: editor.getValue()
				},
				onSuccess: function (transport) {
					self.enable();
					var response = transport.responseText.evalJSON();

					if (response.error) {
						return render_messages('error', container, response.error);
					}

					render_messages('success', container, response.message);
				}
			});
		});

		form.on('submit', function (event) {
			event.stop();

			var data = form.serialize(true);

			clear_messages(this);

			if (!data.hasOwnProperty('revisions[]')) {
				render_messages('error', this, "<?php echo __("You didnt select any revisions to run") ?>");
				Effect.ScrollTo('log', {duration: 0.2});
				return false;
			}

			form.disable();

			new Ajax.Request('index.php?a=revisions', {
				parameters: {
					"revisions[]": data['revisions[]']
				},
				onSuccess: function (transport) {
					form.enable();

                    var response = transport.responseText.evalJSON();

                    if (typeof response.error != 'undefined') {
                        return APP.growler.error('<?php echo _('Error!'); ?>', response.error);
                    }

                    if (response.messages.error) {
                        render_messages('error', 'revisions', response.messages.error, '<?php echo __('The following errors occured:'); ?>');
                    }

                    if (response.messages.success) {
                        render_messages('success', 'revisions', response.messages.success, '<?php echo __('The following actions completed successfuly:'); ?>');
                    }

                    var revision = parseInt(response.revision);
                    if (!isNaN(revision)) {
                    	var rows = form.select('tr[data-revision]');

                		rows.each(function (row) {
                			row.removeClassName('ran');
                			if (row.getAttribute('data-revision') > revision) {
                				return;
                			}
                			row.addClassName('ran');
                			row.down('.revision-files').hide();
                			row.down('input[type="checkbox"]').checked = false;
                		});
                    }

                    Effect.ScrollTo('log', {duration: 0.2});
				}
			});
		});
	});
</script>