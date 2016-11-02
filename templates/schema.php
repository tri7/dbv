<?php
	$selected = "tables";
	if (in_array($this->_action, array("tables", "views"))) {
		$selected = $this->_action;
	}
?>

<h2><?php echo __('Database schema'); ?></h2>
<div class="log"></div>

<?php if (isset($this->schema) && count($this->schema)) { ?>
    <form method="post" action="" class="nomargin" id="schema">
        <table class="table table-condensed table-striped table-bordered">
            <thead>
                <tr>
                    <th style="width: 13px;"><input type="checkbox" style="margin-top: 0;" /></th>
                    <th><?php echo _('Schema object'); ?></th>
                    <th style="text-align: center; width: 50px;"><?php echo __('In DB'); ?></th>
                    <th style="text-align: center; width: 50px;"><?php echo __('On disk'); ?></th>
                </tr>
            </thead>
            <tbody>
                
            </tbody>
        </table>

        <button data-role="create" class="btn btn-primary btn-mini"><?php echo __('Inserir na base de dados local'); ?></button>
        <button data-role="export" class="btn btn-primary btn-mini"><?php echo __('Exportar para o disco local'); ?></button>
        <button data-role="alteracoes" class="btn btn-primary btn-mini"><?php echo __('Importar alterações'); ?></button>
    </form>

    <script type="text/javascript">
        $('schema').select('button[data-role]').invoke('observe', 'click', function (event) {
            event.stop();

            var form = this.up('form');
            var data = form.serialize(true);
            var dest;

            form.disable();
            clear_messages('left');

            data.action = this.getAttribute('data-role');

            if (this.getAttribute('data-role') == 'alteracoes') {
                dest = 'index.php?a=alteracoes';
            }else{
                dest = 'index.php?a=schema';
            };

            new Ajax.Request(dest, {
                parameters: data,
                onSuccess: function (transport) {

                    if (this.getAttribute('data-role') == 'alteracoes') {
                        window.location.href = "http://localhost/nos-app/db_tools/";
                    }
                    
                    form.enable();
                    
                    var response = transport.responseText.evalJSON();

                    if (typeof response.error != 'undefined') {
                        return APP.growler.error('<?php echo __('Error!'); ?>', response.error);
                    }
                    if (response.messages.error) {
                        render_messages('error', 'left', response.messages.error, '<?php echo __('The following errors occured:'); ?>');
                    }
                    if (response.messages.success) {
                        render_messages('success', 'left', response.messages.success, '<?php echo __('The following actions completed successfuly:'); ?>');
                    }

                    var items = response.items;
                    for (var name in items) {
                        var row = $('object-' + name).up('tr');
                        for (var key in items[name]) {
                            var label = row.down('[data-role="' + key + '"]').down('.label');
                            label.removeClassName('label-success').removeClassName('label-important');

                            if (items[name][key]) {
                                label.addClassName('label-success').update('YES');
                            } else {
                                label.addClassName('label-important').update('NO');
                            }
                        }
                    }
                    Effect.ScrollTo('log', {duration: 0.2});

                }
            });
        });
    </script>
<?php 
} else { ?>
	<div class="alert alert-info nomargin"><?php echo __('No schema objects found on disk or in the database.'); ?></div>
<?php } ?>
