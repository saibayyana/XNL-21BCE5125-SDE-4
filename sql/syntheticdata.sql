-- PROCEDURE: Generate Synthetic Data
DELIMITER $$
CREATE PROCEDURE GenerateSyntheticData()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000000 DO
        INSERT INTO Users (Name, Email, Phone) VALUES (
            CONCAT('User', i),
            CONCAT('user', i, '@example.com'),
            CONCAT('+12345678', i)
        );
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL GenerateSyntheticData();