-- TRIGGER: Prevent Overdraft in Accounts

DELIMITER $$
CREATE TRIGGER prevent_overdraft BEFORE INSERT ON FinancialTransactions
FOR EACH ROW
BEGIN
    DECLARE balance DECIMAL(15,2);
    SELECT Balance INTO balance FROM Accounts WHERE UserID = NEW.UserID;
    IF NEW.TransactionType = 'Withdrawal' AND balance < NEW.Amount THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient funds';
    END IF;
END $$
DELIMITER ;