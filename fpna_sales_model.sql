-- ============================================================
-- FP&A Performance Project: Schema, Data & Marginality View
-- Engine: SQLite / ANSI SQL
-- ============================================================

-- 1. Tabella Dimensione: Prodotti
DROP TABLE IF EXISTS Prodotti;
CREATE TABLE Prodotti (
    ID_Prodotto INTEGER PRIMARY KEY,
    Nome_Prodotto VARCHAR(100) NOT NULL,
    Linea_Business VARCHAR(50) NOT NULL,
    Costo_Standard DECIMAL(10, 2) NOT NULL
);

INSERT INTO Prodotti (ID_Prodotto, Nome_Prodotto, Linea_Business, Costo_Standard) VALUES
(1, 'Scarpa Oxford Classic', 'Corporate', 80.00),
(2, 'Sneaker Urban Run', 'Retail', 45.00),
(3, 'Mocassino Elegance', 'Corporate', 70.00);

-- 2. Tabella Fatti: Vendite Dettaglio (Actual)
DROP TABLE IF EXISTS Vendite_Dettaglio;
CREATE TABLE Vendite_Dettaglio (
    ID_Transazione INTEGER PRIMARY KEY AUTOINCREMENT,
    Data_Vendita DATE NOT NULL,
    ID_Prodotto INTEGER NOT NULL,
    Quantita INTEGER NOT NULL,
    Prezzo_Unitario DECIMAL(10, 2) NOT NULL,
    Ricavo_Totale DECIMAL(10, 2) NOT NULL,
    Costo_Totale DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Prodotto) REFERENCES Prodotti(ID_Prodotto)
);

INSERT INTO Vendite_Dettaglio (Data_Vendita, ID_Prodotto, Quantita, Prezzo_Unitario, Ricavo_Totale, Costo_Totale) VALUES
('2026-08-01', 1, 1000, 150.00, 150000.00, 80000.00),
('2026-08-03', 2, 2000, 100.00, 200000.00, 90000.00),
('2026-08-10', 3, 1000, 180.00, 180000.00, 70000.00),
('2026-08-20', 2, 2400, 100.00, 240000.00, 108000.00);

-- 3. Tabella Budget: Target Vendite
DROP TABLE IF EXISTS Budget_Vendite;
CREATE TABLE Budget_Vendite (
    ID_Budget INTEGER PRIMARY KEY AUTOINCREMENT,
    Mese_Anno VARCHAR(7) NOT NULL,
    ID_Prodotto INTEGER NOT NULL,
    Ricavo_Budget DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Prodotto) REFERENCES Prodotti(ID_Prodotto)
);

INSERT INTO Budget_Vendite (Mese_Anno, ID_Prodotto, Ricavo_Budget) VALUES
('2026-08', 1, 140000.00),
('2026-08', 2, 500000.00),
('2026-08', 3, 200000.00);

-- 4. Vista Direzionale: Calcolo Marginalità e Performance
DROP VIEW IF EXISTS vw_Vendite_Marginalita;
CREATE VIEW vw_Vendite_Marginalita AS
SELECT 
    v.Data_Vendita,
    v.ID_Prodotto,
    p.Nome_Prodotto,
    p.Linea_Business,
    v.Ricavo_Totale,
    ROUND((v.Ricavo_Totale - v.Costo_Totale) / v.Ricavo_Totale, 4) AS Margine_Percentuale
FROM Vendite_Dettaglio v
INNER JOIN Prodotti p ON v.ID_Prodotto = p.ID_Prodotto
WHERE v.ID_Prodotto > 0 AND p.ID_Prodotto IN (1, 2, 3)
ORDER BY v.Data_Vendita DESC;
