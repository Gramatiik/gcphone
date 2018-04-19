ALTER TABLE `users` ADD `phone_number` VARCHAR(10) NULL;
ALTER TABLE `users` ADD UNIQUE (`phone_number`);

CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(10) NOT NULL,
  `to` varchar(10) NOT NULL,
  `content` varchar(255) NOT NULL DEFAULT '0',
  `at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isRead` int(11) NOT NULL DEFAULT '0'
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `phone_number` varchar(10) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

-- CONVERT
-- INSERT into phone_users_contacts ( identifier, number, display)
-- (Select user_phonelist.owner_id , users.phone_number , CONCAT(users.prenom, ' ', users.nom)
-- from user_phonelist left join users on users.identifier = user_phonelist.contact_id)
