--La clinica "Salute Integrata" intende sviluppare un sistema per digitalizzare e migliorare la gestione delle sue operazioni quotidiane. 

--Il sistema deve coprire la gestione dei pazienti, degli appuntamenti, delle fatturazioni, 
--delle terapie somministrate, del personale medico e del magazzino farmaceutico.


--Ogni paziente è registrato con un ID univoco, nome, cognome, data di nascita, indirizzo, numero di telefono, email 
--e il medico di riferimento. 

--I pazienti possono avere diverse patologie, e il sistema deve tracciare le diagnosi fatte, 
--le terapie prescritte e le visite programmate.


--Il sistema deve permettere la gestione degli appuntamenti. 
--Ogni appuntamento ha un ID univoco, una data, un'ora, una descrizione e un medico associato. 
--Gli appuntamenti possono essere programmati, riprogrammati o cancellati. 
--Il sistema deve tracciare lo stato degli appuntamenti (prenotato, completato, cancellato) e 
--le note del medico al termine della visita.
--Ogni visita e terapia somministrata devono generare una fattura, 
--che includa il costo delle prestazioni, la data e il metodo di pagamento (contanti, carta, bonifico). 
--Il sistema deve supportare la creazione, la modifica e 
--la cancellazione delle fatture, e deve tenere traccia dei pagamenti pendenti e delle fatture saldate.
--Ogni medico ha un ID univoco, nome, cognome, specializzazione, orari di lavoro e salario. 
--Il sistema deve tenere traccia degli appuntamenti assegnati a ciascun medico e del numero di pazienti visitati.
--La clinica deve gestire un magazzino di farmaci utilizzati nelle terapie. 
--Ogni farmaco ha un codice univoco, un nome, una quantità in magazzino, una data di scadenza e un punto di riordino. 
--Il sistema deve consentire l'aggiornamento delle scorte e la registrazione delle quantità utilizzate in ogni visita o terapia.
--Si richiede di progettare uno schema ER per questo sistema di gestione e la relativa traduzione SQL.



CREATE TABLE Paziente(
	pazienteID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	cognome VARCHAR(250) NOT NULL,
	dataNascita DATE NOT NULL,
	indirizzo VARCHAR(250) NOT NULL,
	telefono INT NOT NULL,
	email VARCHAR(250) NOT NULL,
	medicoRIF INT NOT NULL
);

CREATE TABLE Medico(
	medicoID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	cognome VARCHAR(250) NOT NULL,
	specializzazione VARCHAR(250) NOT NULL,
	oreLavoro INT NOT NULL,
	salario DECIMAL(5,2) NOT NULL,
);

CREATE TABLE Patologia(
	patologiaID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	descrizione TEXT NOT NULL
);

CREATE TABLE Appuntamento(
	appuntamentoID INT PRIMARY KEY IDENTITY(1,1),
	dataAppuntamento DATE NOT NULL,
	ora TIME NOT NULL,
	descrizione TEXT NOT NULL,
	statoAppuntamento VARCHAR(250) CHECK( statoAppuntamento IN('Prenotato', 'Completato', 'Cancellato')),
	noteMedico TEXT  DEFAULT  'Nessuna nota',
	medicoRIF INT NOT NULL,
	pazienteRIF INT NOT NULL,
	FOREIGN KEY (medicoRIF) REFERENCES Medico(medicoID) ON DELETE CASCADE,
	FOREIGN KEY (pazienteRIF) REFERENCES Paziente(pazienteID) ON DELETE CASCADE
);


CREATE TABLE Terapia(
	terapiaID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	dataFineTerapia DATE NOT NULL,
	pazienteRIF INT NOT NULL,
	patologiaRIF INT NOT NULL,
	FOREIGN KEY (pazienteRIF) REFERENCES Paziente(pazienteID) ON DELETE CASCADE,
	FOREIGN KEY (patologiaRIF) REFERENCES Patologia(patologiaID) ON DELETE CASCADE
);

CREATE TABLE Fattura_appuntamento(
		fatturaAppuntamento INT PRIMARY KEY IDENTITY(1,1),
		costo DECIMAL(5,2) NOT NULL,
		data_fattura DATE NOT NULL,
		metodoPagamento VARCHAR(250) NOT NULL CHECK( metodoPagamento IN('Contanti', 'Carta', 'Bonifico')),
		saldato VARCHAR(250) NOT NULL,
		appuntamentoRIF INT NOT NULL,
		FOREIGN KEY (appuntamentoRIF) REFERENCES Appuntamento(appuntamentoID) ON DELETE CASCADE
);

CREATE TABLE Fattura_Terapia(
	fatturaTerapiaID INT PRIMARY KEY IDENTITY(1,1),
	costo DECIMAL(5,2) NOT NULL,
	data_fattura DATE NOT NULL,
	metodoPagamento VARCHAR(250) NOT NULL CHECK( metodoPagamento IN('Contanti', 'Carta', 'Bonifico')),
	saldato VARCHAR(250) NOT NULL,
	terapiaRIF INT NOT NULL,
	FOREIGN KEY (terapiaRIF) REFERENCES Terapia(terapiaID) ON DELETE CASCADE
);

CREATE TABLE Farmaco (
	farmacoID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	quantita INT NOT NULL,
	dataScadenza DATE NOT NULL,
	puntoRiordino INT NOT NULL,
	terapiaRIF INT NOT NULL,
	FOREIGN KEY (terapiaRIF) REFERENCES Terapia(terapiaID) ON DELETE CASCADE
);


--------------------------------------------------------------------------------------------------
--INSERT


-- Inserimento di dati nella tabella Medico
INSERT INTO Medico (nome, cognome, specializzazione, oreLavoro, salario)
VALUES ('Giovanni', 'Verdi', 'Cardiologia', 40, 500.00),
       ('Anna', 'Neri', 'Dermatologia', 35, 450.00);
INSERT INTO Medico (nome, cognome, specializzazione, oreLavoro, salario)
VALUES	   ('Francesca', 'Franc', 'Neurologa', 25, 280.00);


-- Inserimento di dati nella tabella Paziente
INSERT INTO Paziente (nome, cognome, dataNascita, indirizzo, telefono, email, medicoRIF)
VALUES ('Mario', 'Rossi', '1980-05-15', 'Via Roma 1, Roma', 123456789, 'mario.rossi@example.com', 1),
       ('Luca', 'Bianchi', '1990-07-20', 'Via Milano 2, Milano', 987654321, 'luca.bianchi@example.com', 2);
INSERT INTO Paziente (nome, cognome, dataNascita, indirizzo, telefono, email, medicoRIF)
VALUES ('Giacomo', 'Giacomino', '1992-05-15', 'Via le mani 1, Roma', 44556, 'giacomo.giacomino@example.com', 3);

-- Inserimento di dati nella tabella Patologia
INSERT INTO Patologia (nome, descrizione)
VALUES ('Ipertensione', 'Pressione sanguigna elevata'),
       ('Diabete', 'Livelli elevati di zucchero nel sangue');
INSERT INTO Patologia (Nome, Descrizione)
VALUES ('Diabete2', 'Malattia cronica caratterizzata da alti livelli di glucosio nel sangue');

-- Inserimento di dati nella tabella Appuntamento
INSERT INTO Appuntamento (dataAppuntamento, ora, descrizione, statoAppuntamento, noteMedico, medicoRIF, pazienteRIF)
VALUES ('2024-09-25', '10:00:00', 'Visita di controllo', 'Prenotato', 'Nessuna nota', 1, 1),
       ('2024-09-26', '11:00:00', 'Consulto specialistico', 'Completato', 'Portare esami precedenti', 2, 2);
INSERT INTO Appuntamento (dataAppuntamento, ora, descrizione, statoAppuntamento, noteMedico, medicoRIF, pazienteRIF)
VALUES ('2024-04-25', '10:00:00', 'Visita di controllo', 'Prenotato', 'Nessuna nota', 1, 1),
       ('2024-01-26', '11:00:00', 'Consulto specialistico', 'Completato', 'Portare esami precedenti', 2, 2);
INSERT INTO Appuntamento (dataAppuntamento, ora, descrizione, statoAppuntamento, noteMedico, medicoRIF, pazienteRIF)
VALUES ('2024-09-28', '10:00:00', 'Visita di controllo', 'Prenotato', 'Nessuna nota', 1, 1),
       ('2024-09-29', '11:00:00', 'Consulto specialistico', 'Completato', 'Portare esami precedenti', 2, 2);
INSERT INTO Appuntamento (dataAppuntamento, ora, descrizione, statoAppuntamento, noteMedico, medicoRIF, pazienteRIF)
VALUES ('2024-09-25', '12:00:00', 'Visita di controllo', 'Prenotato', 'Nessuna nota', 1, 1),
       ('2024-09-25', '13:00:00', 'Consulto specialistico', 'Completato', 'Portare esami precedenti', 1, 2);
INSERT INTO Appuntamento (dataAppuntamento, ora, descrizione, statoAppuntamento, noteMedico, medicoRIF, pazienteRIF)
VALUES ('2024-09-25', '07:00:00', 'Visita di controllo', 'Cancellato', 'Nessuna nota', 1, 1),
       ('2024-09-25', '08:00:00', 'Consulto specialistico', 'Cancellato', 'Portare esami precedenti', 1, 2);

-- Inserimento di dati nella tabella Terapia
INSERT INTO Terapia (nome, pazienteRIF, patologiaRIF, dataFineTerapia)
VALUES ('Terapia Antipertensiva', 1, 1, '2024-10-25'),
       ('Terapia Insulinica', 2, 2, '2024-12-25');
INSERT INTO terapia (nome, pazienteRIF, patologiaRIF, dataFineTerapia)
VALUES ('Terapia del Suono', 3,3, '2024-04-25');
INSERT INTO terapia (nome, pazienteRIF, patologiaRIF, dataFineTerapia)
VALUES ('Terapia del Suono', 3,1, '2024-09-25');



-- Inserimento di dati nella tabella Fattura_appuntamento
INSERT INTO Fattura_appuntamento (costo, data_fattura, metodoPagamento, saldato, appuntamentoRIF)
VALUES (100.00, '2024-09-25', 'Carta', 'Sì', 1),
       (150.00, '2024-09-26', 'Contanti', 'No', 2);
INSERT INTO Fattura_appuntamento (costo, data_fattura, metodoPagamento, saldato, appuntamentoRIF)
VALUES (100.00, '2024-04-25', 'Bonifico', 'Sì', 1),
       (150.00, '2024-01-26', 'Contanti', 'No', 2);

-- Inserimento di dati nella tabella Fattura_Terapia
INSERT INTO Fattura_Terapia (costo, data_fattura, metodoPagamento, saldato, terapiaRIF)
VALUES (200.00, '2024-09-25', 'Bonifico', 'Sì', 1),
       (250.00, '2024-09-26', 'Carta', 'No', 2);

INSERT INTO Farmaco (nome, quantita, dataScadenza, puntoRiordino, terapiaRIF) VALUES 
('Paracetamolo', 100, '2025-12-31', 50, 1),
('Ibuprofene', 200, '2024-06-30', 100, 2),
('Amoxicillina', 150, '2023-11-15', 75, 3);

INSERT INTO Farmaco (nome, quantita, dataScadenza, puntoRiordino, terapiaRIF) VALUES 
('Cardioaspirina', 49, '2025-12-31', 50, 1);
INSERT INTO Farmaco (nome, quantita, dataScadenza, puntoRiordino, terapiaRIF) VALUES 
('Glicerolo', 49, '2024-09-30', 50, 1);

INSERT INTO Farmaco (nome, quantita, dataScadenza, puntoRiordino, terapiaRIF) VALUES 
('Zitromax', 49, '2024-10-22', 50, 1);
INSERT INTO Farmaco (nome, quantita, dataScadenza, puntoRiordino, terapiaRIF) VALUES 
('Triatec', 49, '2024-10-23', 50, 1);



---------------------------------------------------------------------------------------------------
--Query

--1.	Recupera l'elenco completo dei pazienti registrati nella clinica.
SELECT *
	FROM Paziente

--2.	Recupera i dettagli di tutti gli appuntamenti programmati per una data specifica.

SELECT P.nome + ' ' + P.cognome AS Paziente, A.dataAppuntamento AS Appuntamento, A.descrizione AS Descrizione
	FROM Appuntamento AS A
	JOIN Paziente AS P ON a.pazienteRIF = P.pazienteID
	WHERE A.dataAppuntamento = '2024-09-25';

--3.	Recupera i nomi e cognomi dei pazienti assegnati a un medico specifico.

SELECT P.nome + ' ' + P.cognome AS Paziente, M.nome + ' ' + M.cognome AS Medico
	FROM Paziente AS P
	JOIN Appuntamento AS A ON P.pazienteID = A.pazienteRIF
	JOIN Medico AS M ON A.medicoRIF = M.medicoID
	WHERE M.medicoID = 1;


--4.	Recupera l'elenco dei pazienti che hanno una diagnosi di "diabete" registrata nel sistema.

SELECT P.nome + ' ' + P.cognome AS Paziente, PAT.nome AS Patologia
	FROM Paziente AS P
	JOIN Terapia AS T ON P.pazienteID = T.pazienteRIF
	JOIN Patologia AS PAT ON T.patologiaRIF = PAT.patologiaID
	WHERE PAT.nome = 'Diabete';

SELECT * FROM Paziente

--5.	Recupera tutte le fatture emesse per visite effettuate nel mese di settembre.

SELECT *
	FROM Fattura_appuntamento AS FA
	WHERE MONTH(FA.data_fattura) = '09'

--6.	Conta il numero totale di appuntamenti prenotati in una settimana specifica.

SELECT COUNT(*) AS AppuntamentiUltimaSettembre
	FROM Appuntamento
	WHERE Appuntamento.dataAppuntamento BETWEEN '2024-09-23' AND '2024-09-30'

--7.	Recupera l'elenco delle terapie somministrate a un paziente specifico.

SELECT T.nome AS Terapia
	FROM Terapia AS T
	JOIN Paziente AS P ON T.pazienteRIF = P.pazienteID
	WHERE P.pazienteID = 1

--8.	Recupera i dettagli delle fatture che non sono state ancora saldate.

SELECT *
	FROM Fattura_appuntamento AS FA
	WHERE FA.saldato = 'No'
UNION ALL
SELECT *
	FROM Fattura_Terapia AS FT
	WHERE FT.saldato = 'No'

--9.	Recupera l'elenco dei farmaci che hanno raggiunto il punto di riordino.

SELECT *
	FROM Farmaco AS F
	WHERE F.quantita < F.puntoRiordino


--10.	Recupera il numero di pazienti visitati da un medico specifico in una giornata specifica.

SELECT COUNT(*) AS Visite
	FROM Paziente AS P
	JOIN Appuntamento AS A ON P.pazienteID = A.pazienteRIF
	JOIN Medico AS M ON A.medicoRIF = M.medicoID
	WHERE M.medicoID = 1 AND A.dataAppuntamento = '2024-09-25';

--11.	Recupera il numero totale di appuntamenti cancellati nel corso di un mese.

SELECT *
	FROM Appuntamento AS A
	WHERE A.statoAppuntamento = 'Cancellato' AND MONTH(A.dataAppuntamento) = '09'

--12.	Recupera i dettagli delle fatture pagate con carta di credito.

SELECT *
	FROM Fattura_appuntamento AS FA
	WHERE FA.metodoPagamento = 'Carta'
UNION
SELECT *
	FROM Fattura_Terapia AS FT
	WHERE FT.metodoPagamento = 'Carta'

--13.	Conta il numero di appuntamenti completati per ogni medico nella settimana corrente.

SELECT M.nome + ' ' + M.cognome AS Medico, COUNT(*) AS Appuntamenti
	FROM Appuntamento AS A
	JOIN Medico AS M ON A.medicoRIF = M.medicoID
	
	WHERE M.medicoID = A.medicoRIF AND A.dataAppuntamento BETWEEN DATEADD(day,-7,GetDate()) AND DATEADD(day,7, GetDate())
	GROUP BY nome,cognome

--14.	Recupera l'elenco dei farmaci con una data di scadenza entro i prossimi 30 giorni.

SELECT *
	FROM Farmaco AS F
	WHERE F.dataScadenza < DATEADD(day,30, GetDate()) AND F.dataScadenza > GetDate()


--15.	Recupera il numero di terapie somministrate per una specifica patologia.

SELECT P.nome AS Patologia, COUNT(*)
	FROM Terapia AS T
	JOIN Patologia AS P ON T.patologiaRIF = P.patologiaID
	WHERE P.patologiaID = T.patologiaRIF
	GROUP BY P.nome

--16.	Recupera l'elenco dei pazienti che hanno saltato un appuntamento (stato "cancellato").

SELECT P.nome + ' ' + P.cognome AS Paziente, A.dataAppuntamento
	FROM Paziente AS P
	JOIN Appuntamento AS A ON P.pazienteID = A.pazienteRIF
	WHERE A.statoAppuntamento = 'Cancellato'

--17.	Recupera il costo totale delle terapie somministrate in una giornata specifica.

SELECT SUM(FA.costo) AS CostoTotale
	FROM Fattura_Terapia AS FA
	
--18.	Recupera il numero di farmaci utilizzati per un determinato paziente nell'ultimo mese.

--SELECT COUNT(*) AS NumeroFarmaci
--	FROM Paziente AS P
--	JOIN Terapia AS T ON P.pazienteID = T.pazienteRIF
--	JOIN Farmaco AS F ON F.terapiaRIF = T.terapiaID
--	WHERE P.pazienteID = 1 AND T.dataFineTerapia < DATEADD(day,30, GetDate())

--19.	Recupera il numero di visite completate per ogni paziente con una diagnosi di "ipertensione".

--SELECT COUNT(*)
--	FROM Paziente AS P
--	JOIN Appuntamento AS a ON P.pazienteID = A.pazienteRIF
	
--20.	Recupera l'elenco dei pazienti che non hanno ancora pagato le fatture per le loro visite.

SELECT P.nome + ' ' + P.cognome AS Paziente, FA.data_fattura
	FROM Paziente AS P
	JOIN Appuntamento AS a ON P.pazienteID = A.pazienteRIF
	JOIN Fattura_appuntamento AS FA ON A.appuntamentoID = FA.appuntamentoRIF
	WHERE FA.saldato = 'No';

	------------------------------------------------------------------------------
--VIEW
--1.	Crea una view che mostra tutti i pazienti con le rispettive patologie diagnosticate.

CREATE VIEW ElencoPazienti AS
	SELECT P.nome + ' ' + P.cognome AS Nome_Membro, PA.nome AS Patologia
		FROM Paziente AS P
		JOIN Terapia AS T ON P.pazienteID = T.pazienteRIF
		JOIN Patologia AS PA ON T.patologiaRIF = PA.patologiaID;
		
SELECT * FROM ElencoPazienti;

--2.	Crea una view che elenca gli appuntamenti programmati per una settimana specifica con i dettagli del medico e dello stato.

CREATE VIEW ElencoAppuntamenti
	

--3.	Crea una view che mostra le fatture emesse per un paziente specifico con il relativo stato di pagamento.

CREATE VIEW FatturePaziente AS
	SELECT P.nome + ' ' + P.cognome AS Paziente, FA.saldato+ ' ' + FT.saldato AS Fattura_Appuntamento_Fattura_Terapia
		FROM Paziente AS P
		JOIN Appuntamento AS A ON P.pazienteID = A.pazienteRIF
		JOIN Fattura_appuntamento AS FA ON A.appuntamentoID = FA.appuntamentoRIF
		JOIN Terapia AS T ON P.pazienteID = T.pazienteRIF
		JOIN Fattura_Terapia AS FT ON T.terapiaID = FT.terapiaRIF
		WHERE P.pazienteID = 2

SELECT * FROM FatturePaziente

--4.	Crea una view che elenca tutti i farmaci scaduti o in prossimità di scadenza.

CREATE VIEW FarmaciScadutiProssimi AS
	SELECT *
		FROM Farmaco AS F
		WHERE F.dataScadenza < GETDATE() OR F.dataScadenza < DATEADD(day,30, GetDate())

--5.	Crea una view che mostra il numero di appuntamenti completati per ciascun medico nel mese corrente.

CREATE VIEW AppuntamentiCompletati AS
	SELECT *
		FROM Appuntamento AS A
		JOIN Medico AS M ON A.medicoRIF = M.medicoID
		WHERE A.statoAppuntamento = 'Completato' AND MONTH(A.dataAppuntamento) = MONTH(GetDate())

----------------------------------------------------------------------------------------
--SP

--1.	Crea una stored procedure per inserire un nuovo paziente nel sistema con nome, cognome, data di nascita, diagnosi e medico di riferimento.

CREATE PROCEDURE InsertPaziente
	@nome VARCHAR(250),
	@cognome VARCHAR(250),
	@dataNascita DATE,
	@medicoRiferimento INT,

AS
BEGIN
		BEGIN
				INSERT INTO Paziente (nome, cognome, dataNascita, medicoRIF)
				VALUES ('Federico', 'Giallo', '1980-05-15', 1);
		END
END;

--2.	Crea una stored procedure per aggiornare lo stato di un appuntamento (ad esempio, da "prenotato" a "completato").


--3.	Crea una stored procedure per generare una fattura per una visita, specificando il costo della visita e il metodo di pagamento.


--4.	Crea una stored procedure per aggiornare la quantità di un farmaco quando viene utilizzato durante una terapia.


--5.	Crea una stored procedure per cancellare una fattura non pagata e rimuoverla dal sistema.
