CREATE TABLE `rel_video_audio_legendas` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `video_id` mediumint(11) DEFAULT NULL,
  `som_id` mediumint(11) DEFAULT NULL,
  `legendas_id` mediumint(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rel_video_audio_legendas_videos1_idx` (`video_id`),
  KEY `fk_rel_video_audio_legendas_sons1_idx` (`som_id`),
  KEY `fk_rel_video_audio_legendas_legendas1_idx` (`legendas_id`),
  CONSTRAINT `fk_rel_video_audio_legendas_legendas1` FOREIGN KEY (`legendas_id`) REFERENCES `legendas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rel_video_audio_legendas_sons1` FOREIGN KEY (`som_id`) REFERENCES `sons` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rel_video_audio_legendas_videos1` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8