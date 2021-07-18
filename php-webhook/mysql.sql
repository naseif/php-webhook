/***
  These SQL statements are needed to set up the database for the webhook.
*/

CREATE TABLE `LastPushForRepository` (
  `Id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Username` varchar(200) NOT NULL,
  `Repository` varchar(200) NOT NULL,
  `LastPushDateTime` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DELIMITER $$
CREATE DEFINER=`d034eaa5`@`%` PROCEDURE `SavePush`(IN `@Username` VARCHAR(200), IN `@Repository` VARCHAR(200))
    MODIFIES SQL DATA
IF EXISTS(SELECT 1 FROM LastPushForRepository WHERE Username=@Username AND Repository=@Repository) THEN
  UPDATE LastPushForRepository SET LastPushDateTime=CURRENT_TIMESTAMP() WHERE Username=@Username AND Repository=@Repository;
ELSE
  INSERT INTO LastPushForRepository (Username, Repository, LastPushDateTime) VALUES(@Username,@Repository,CURRENT_TIMESTAMP());
END IF$$
DELIMITER ;
