/*
Progettazione e realizzazione:
Il centro fitness "Energia Pura" sta cercando di sviluppare un sistema per migliorare e digitalizzare 
la gestione delle sue attività quotidiane. 



Il sistema dovrebbe coprire vari aspetti, tra cui la gestione dei membri, la programmazione delle classi, 
la gestione degli istruttori e delle attrezzature, e il monitoraggio dei progressi dei membri.



Ogni membro del centro fitness è registrato nel sistema con un ID unico, nome, cognome, 
data di nascita, sesso, indirizzo email, numero di telefono, e la data di inizio dell'abbonamento.	----------Il membro puo partecipare a piu corsi




I membri possono scegliere tra diversi tipi di abbonamenti (ad esempio, mensile, trimestrale, annuale) 
che differiscono per durata e prezzo.  




Le classi di fitness, come yoga, pilates, spinning e sollevamento pesi, sono un elemento chiave dell'offerta del centro. 
Ogni classe è caratterizzata da un ID unico, nome, descrizione, orario, giorno della settimana e 
numero massimo di partecipanti. 


Inoltre, ogni classe è associata a uno specifico istruttore.


Gli istruttori sono impiegati dal centro fitness e sono registrati nel sistema 
con dettagli quali ID, nome, cognome, specializzazione, e orari di lavoro. 



Ogni istruttore può condurre diverse classi, ma una classe può essere condotta da un solo istruttore per volta.





Il sistema deve anche gestire le prenotazioni delle classi effettuate dai membri. 
Una prenotazione collega un membro a una specifica classe e ne registra la data e l'ora. 
Il sistema dovrebbe consentire ai membri di prenotare le classi online e cancellare le prenotazioni se necessario.



Inoltre, il centro fitness dispone di diverse attrezzature, come tapis roulant, biciclette da spinning e pesi liberi. 

Ogni attrezzatura è catalogata nel sistema con un ID univoco, una descrizione, una data di acquisto e 
uno stato (ad esempio, disponibile, in manutenzione, fuori servizio).


Si richiede di progettare uno schema ER per questo sistema e la relativa traduzione in SQL.
*/


CREATE TABLE Membro(
	membroID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	cognome VARCHAR(250) NOT NULL,
	data_nascita DATE NOT NULL,
	sesso VARCHAR(250) NOT NULL,
	email VARCHAR(250) NOT NULL,
	telefono INT NOT NULL
);

CREATE TABLE Istruttore(
	istruttoreID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	cognome VARCHAR(250) NOT NULL,
	specializzazione VARCHAR(250) NOT NULL,
	ore INT NOT NULL
);

CREATE TABLE Classe(
	classeID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL CHECK( nome IN('Fitness', 'Yoga', 'Pilates', 'Spinning', 'Pesi')),
	descrizione TEXT NOT NULL,
	orario TIME NOT NULL,
	giorno VARCHAR(250) NOT NULL,
	partecipanti INT NOT NULL,
	istruttoreRIF INT NOT NULL,
	FOREIGN KEY (istruttoreRIF) REFERENCES Istruttore(istruttoreID) ON DELETE CASCADE
);

CREATE TABLE Abbonamento(
	abbonamentoID INT PRIMARY KEY IDENTITY(1,1),
	tipo	VARCHAR(250) NOT NULL CHECK( tipo IN('Mensile','Trimestrale','Annuale') ),
	inizio_abbonamento	DATE NOT NULL,
	fine_abbonamento DATE NOT NULL, 
	costo DECIMAL(5,2) NOT NULL,
	membroRIF INT,
	FOREIGN KEY (membroRIF) REFERENCES Membro(membroID) ON DELETE CASCADE,
);

CREATE TABLE Prenotazione(
	prenotazioneID INT PRIMARY KEY IDENTITY(1,1),
	data_prenotazione DATE NOT NULL,
	data_annullamento DATE DEFAULT NULL,
	membroRIF INT NOT NULL,
	classeRIF INT NOT NULL,
	FOREIGN KEY (membroRIF) REFERENCES Membro(membroID) ON DELETE CASCADE,
	FOREIGN KEY (classeRIF) REFERENCES Classe(classeID) ON DELETE CASCADE
);



CREATE TABLE Attrezzo(
	attrezzoID INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(250) NOT NULL,
	descrizione TEXT NOT NULL,
	data_acquisto DATE NOT NULL,
	stato VARCHAR(250) NOT NULL,
	classeRIF INT NOT NULL,
	FOREIGN KEY (classeRIF) REFERENCES Classe(classeID) ON DELETE CASCADE
);


INSERT INTO Membro (nome, cognome, data_nascita, sesso, email, telefono) VALUES 
('Mario', 'Rossi', '1985-06-15', 'Maschio', 'mario.rossi@example.com', 123456790),
('Luca', 'Bianchi', '1990-08-22', 'Maschio', 'luca.bianchi@example.com', 234568901),
('Giulia', 'Verdi', '1992-11-30', 'Femmina', 'giulia.verdi@example.com', 345689012);

INSERT INTO Membro (nome, cognome, data_nascita, sesso, email, telefono) VALUES 
('Alessandro', 'Ferrari', '1988-04-12', 'Maschio', 'alessandro.ferrari@example.com', 467890123),
('Elena', 'Russo', '1995-07-19', 'Femmina', 'elena.russo@example.com', 567890134),
('Francesca', 'Marini', '1983-12-05', 'Femmina', 'francesca.marini@example.com', 678902345);

INSERT INTO Membro (nome, cognome, data_nascita, sesso, email, telefono) VALUES 
('Andrea', 'Carbone', '1995-04-12', 'Maschio', 'andrea.carbone@example.com', 345677757);
INSERT INTO Membro (nome, cognome, data_nascita, sesso, email, telefono) VALUES 
('Gianmarco', 'Ferranti', '1992-04-12', 'Maschio', 'gianmarco.ferranti@example.com', 008873663);
INSERT INTO Membro (nome, cognome, data_nascita, sesso, email, telefono) VALUES 
('Pippo', 'Pluto', '1997-04-12', 'Maschio', 'pippo.pluto@example.com', 11133344);
INSERT INTO Membro (nome, cognome, data_nascita, sesso, email, telefono) VALUES 
('Paperino', 'Paperin', '1997-04-12', 'Maschio', 'paperino.paperin@example.com', 4446667);


INSERT INTO Istruttore (nome, cognome, specializzazione, ore) VALUES 
('Anna', 'Neri', 'Yoga', 20),
('Marco', 'Gialli', 'Fitness', 25),
('Sara', 'Blu', 'Pilates', 15);

INSERT INTO Istruttore (nome, cognome, specializzazione, ore) VALUES 
('Lorenzo', 'Verdi', 'Spinning', 30),
('Chiara', 'Bianchi', 'Pesi', 20),
('Davide', 'Rossi', 'Yoga', 25);

INSERT INTO Istruttore (nome, cognome, specializzazione, ore) VALUES 
('Mario', 'Rossi', 'Spinning', 30);
INSERT INTO Istruttore (nome, cognome, specializzazione, ore) VALUES 
('Ciccio', 'Spiccio', 'Spinning', 10);



INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES 
('Fitness', 'Allenamento cardiovascolare e di resistenza', '18:00:00', 'Lunedì', 20, 1),
('Yoga', 'Sessione di yoga per il rilassamento e la flessibilità', '09:00:00', 'Mercoledì', 15, 2),
('Pilates', 'Esercizi di pilates per il core e la postura', '17:00:00', 'Venerdì', 10, 3);

INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES 
('Spinning', 'Allenamento di ciclismo indoor', '19:00:00', 'Martedì', 25, 4),
('Pesi', 'Allenamento con pesi liberi e macchine', '10:00:00', 'Giovedì', 30, 5),
('Yoga', 'Sessione avanzata di yoga', '08:00:00', 'Sabato', 20, 6);

INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES 
('Spinning', 'Allenamento di ciclismo outdoor', '10:00:00', 'Sabato', 25, 5);

INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES 
('Fitness', 'Allenamento ad alta intensità con esercizi funzionali', '07:00:00', 'Lunedì', 15, 1),
('Yoga', 'Lezione di danza-fitness con musica latina', '18:30:00', 'Martedì', 25, 2),
('Pilates', 'Allenamento di pugilato per migliorare forza e resistenza', '20:00:00', 'Mercoledì', 20, 3),
('Spinning', 'Allenamento intervallato ad alta intensità', '06:30:00', 'Giovedì', 10, 4),
('Pesi', 'Esercizi di allungamento muscolare', '09:00:00', 'Venerdì', 12, 5),
('Yoga', 'Lezione di danza moderna per tutti i livelli', '17:00:00', 'Sabato', 18, 6);

INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES 
('Spinning', 'Allenamento di ciclismo outdoor', '11:00:00', 'Mercoledì', 25, 5);

INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES 
('Spinning', 'Allenamento di ciclismo outdoor', '11:00:00', 'Martedì', 25, 5);
INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES 
('Spinning', 'Allenamento di ciclismo outdoor', '10:00:00', 'Giovedì', 25, 5);
INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES 
('Spinning', 'Allenamento di ciclismo outdoor', '04:00:00', 'Giovedì', 25, 7);
INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES 
('Spinning', 'Allenamento di ciclismo outdoor', '04:00:00', 'Lunedì', 25, 3);
INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES 
('Spinning', 'Allenamento di ciclismo outdoor', '04:00:00', 'Lunedì', 25, 8);
INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES 
('Spinning', 'Allenamento di ciclismo outdoor', '04:00:00', 'Venerdì', 25, 8);



-----------------------------

INSERT INTO Abbonamento (tipo, inizio_abbonamento, fine_abbonamento, costo, membroRIF) VALUES 
('Mensile', '2024-09-01', '2024-09-30', 50.00, 1),
('Trimestrale', '2024-09-01', '2024-11-30', 135.00, 2),
('Annuale', '2024-09-01', '2025-08-31', 480.00, 3);

INSERT INTO Abbonamento (tipo, inizio_abbonamento, fine_abbonamento, costo, membroRIF) VALUES 
('Mensile', '2024-10-01', '2024-10-31', 55.00, 4),
('Trimestrale', '2024-10-01', '2024-12-31', 150.00, 5),
('Annuale', '2024-10-01', '2025-09-30', 500.00, 6);

INSERT INTO Abbonamento (tipo, inizio_abbonamento, fine_abbonamento, costo, membroRIF) VALUES 
('Annuale', '2023-01-01', '2023-12-31', 480.00, 7),
('Annuale', '2024-01-01', '2024-12-31', 480.00, 7),
('Annuale', '2023-01-01', '2023-12-31', 480.00, 8),
('Mensile', '2023-01-01', '2023-01-31', 55.00, 9),
('Annuale', '2023-01-01', '2023-12-31', 480.00, 10),
('Trimestrale', '2024-01-01', '2024-03-31', 55.00, 10),
('Trimestrale', '2024-04-01', '2024-06-30', 55.00, 10),
('Trimestrale', '2024-07-01', '2024-09-30', 55.00, 10);




INSERT INTO Prenotazione (data_prenotazione, membroRIF, classeRIF) VALUES 
('2024-09-20', 1, 1),
('2024-09-21', 2, 2),
('2024-09-22', 3, 3);

INSERT INTO Prenotazione (data_prenotazione, membroRIF, classeRIF) VALUES 
('2024-10-05', 4, 4),
('2024-10-06', 5, 5),
('2024-10-07', 6, 6);

INSERT INTO Prenotazione (data_prenotazione, membroRIF, classeRIF) VALUES 
('2024-08-20', 1, 5);
INSERT INTO Prenotazione (data_prenotazione, membroRIF, classeRIF) VALUES 
('2024-08-20', 1, 3);
INSERT INTO Prenotazione (data_prenotazione, membroRIF, classeRIF, data_annullamento) VALUES 
('2024-09-10', 1, 3, '2024-09-11');
INSERT INTO Prenotazione (data_prenotazione, membroRIF, classeRIF) VALUES 
('2024-08-20', 1, 17);

INSERT INTO Prenotazione (data_prenotazione, membroRIF, classeRIF) VALUES 
('2022-08-20', 1, 17);
INSERT INTO Prenotazione (data_prenotazione, membroRIF, classeRIF) VALUES 
('2022-08-21', 3, 5);



INSERT INTO Attrezzo (nome, descrizione, data_acquisto, stato, classeRIF) VALUES 
('Tapis Roulant', 'Macchina per la corsa', '2023-01-15', 'Disponibile', 1),
('Cyclette', 'Bicicletta stazionaria', '2023-02-20', 'In Manutenzione', 2),
('Pesi', 'Set di pesi liberi', '2023-03-10', 'Fuori Servizio', 3),
('Ellittica', 'Macchina per allenamento cardiovascolare', '2023-04-15', 'Disponibile', 4),
('Manubri', 'Set di manubri regolabili', '2023-05-20', 'In Manutenzione', 5),
('Panca', 'Panca per sollevamento pesi', '2023-06-10', 'Fuori Servizio', 6);


INSERT INTO Attrezzo (nome, descrizione, data_acquisto, stato, classeRIF) VALUES 
('Tapis Roulant', 'Macchina per la corsa', '2023-01-15', 'Disponibile', 1),
('Cyclette', 'Bicicletta stazionaria', '2023-02-20', 'In Manutenzione', 2),
('Pesi', 'Set di pesi liberi', '2023-03-10', 'Fuori Servizio', 3),
('Ellittica', 'Macchina per allenamento cardiovascolare', '2023-04-15', 'Disponibile', 4),
('Manubri', 'Set di manubri regolabili', '2023-05-20', 'In Manutenzione', 5),
('Panca', 'Panca per sollevamento pesi', '2023-06-10', 'Fuori Servizio', 6);


INSERT INTO Attrezzo (nome, descrizione, data_acquisto, stato, classeRIF) VALUES 
('Tapis Roulant', 'Macchina per la corsa', '2017-01-15', 'Disponibile', 1),
('Cyclette', 'Bicicletta stazionaria', '2016-02-20', 'In Manutenzione', 2);






SELECT * FROM Membro;
SELECT * FROM Abbonamento;
SELECT * FROM Prenotazione;
SELECT * FROM Classe;
SELECT * FROM Istruttore;



--1.	Query base: Recupera tutti i membri registrati nel sistema.

SELECT *
	FROM Membro;

--2.	Recupera il nome e il cognome di tutti i membri che hanno un abbonamento mensile.

SELECT nome, cognome
	FROM Membro
	JOIN Abbonamento ON Membro.membroID = Abbonamento.membroRIF
	WHERE Abbonamento.tipo = 'Mensile';

--3.	Recupera l'elenco delle classi di yoga offerte dal centro fitness.

SELECT *
	FROM Classe
	WHERE Classe.nome = 'Yoga';

--4.	Recupera il nome e cognome degli istruttori che insegnano Pilates.

SELECT Istruttore.nome, Istruttore.cognome
	FROM Istruttore
	JOIN Classe ON Istruttore.istruttoreID = Classe.istruttoreRIF
	WHERE Classe.nome = 'Pilates';

--5.	Recupera i dettagli delle classi programmate per il lunedì.

SELECT *
	FROM Classe
	WHERE Classe.giorno = 'Lunedì';

--6.	Recupera l'elenco dei membri che hanno prenotato una classe di spinning.

SELECT Membro.nome AS Nome, Membro.cognome AS Cognome
	FROM Membro
	JOIN Prenotazione ON Membro.membroID = Prenotazione.membroRIF
	JOIN Classe ON Prenotazione.classeRIF = Classe.classeID
	WHERE Classe.nome = 'Spinning';

--7.	Recupera tutte le attrezzature che sono attualmente fuori servizio.
SELECT *
	FROM Attrezzo
	WHERE Attrezzo.stato = 'Fuori Servizio';

--8.	Conta il numero di partecipanti per ciascuna classe programmata per il mercoledì.

SELECT Classe.nome , SUM(partecipanti) AS PartecipantiContati
	FROM Classe
	WHERE Classe.giorno = 'Mercoledì'
	GROUP BY Classe.nome
	ORDER BY Classe.nome ASC

--9.	Recupera l'elenco degli istruttori disponibili per tenere una lezione il sabato.

SELECT DISTINCT Istruttore.nome AS Nome, Istruttore.cognome AS Cognome
	FROM Istruttore
	JOIN Classe ON Istruttore.istruttoreID = Classe.istruttoreRIF
	WHERE Istruttore.istruttoreID NOT IN(
							SELECT Classe.istruttoreRIF FROM Classe WHERE Classe.giorno = 'Sabato') 
	ORDER BY Nome;

--10.	Recupera tutti i membri che hanno un abbonamento attivo dal 2023.

SELECT *
	FROM Membro
	JOIN Abbonamento ON Membro.membroID = Abbonamento.membroRIF
	WHERE  Abbonamento.inizio_abbonamento >= '2023-01-01' AND
		(Abbonamento.tipo = 'Mensile' AND DATEADD(month, 1, Abbonamento.inizio_abbonamento) >= GETDATE()) OR
		(Abbonamento.tipo = 'Trimestrale' AND DATEADD(month, 3, Abbonamento.inizio_abbonamento) >= GETDATE()) OR
		(Abbonamento.tipo = 'Annuale' AND DATEADD(year, 1, Abbonamento.inizio_abbonamento) >= GETDATE());

--?????????????????

--11.	Trova il numero massimo di partecipanti per tutte le classi di sollevamento pesi.

SELECT Classe.partecipanti
	FROM Classe
	WHERE Classe.nome = 'Pesi';

--12.	Recupera le prenotazioni effettuate da un membro specifico.

SELECT *
	FROM Prenotazione
	JOIN Membro ON Prenotazione.membroRIF = Membro.membroID
	WHERE Membro.nome = 'Mario'
	ORDER BY nome

--13.	Recupera l'elenco degli istruttori che conducono più di 5 classi alla settimana.

SELECT  Istruttore.nome AS NomeIstruttore, COUNT(istruttoreID) AS Lezioni_Settimanali
	FROM Istruttore
	JOIN Classe ON Istruttore.istruttoreID = Classe.istruttoreRIF
	GROUP BY Istruttore.nome
	HAVING  COUNT(istruttoreID) >=5 
	ORDER BY COUNT(istruttoreID)

--14.	Recupera le classi che hanno ancora posti disponibili per nuove prenotazioni.

SELECT  nome AS Nome, giorno AS Giorno, orario AS Orario, partecipanti - COUNT(*) AS Posti_Disponibili
	FROM Classe AS C
		WHERE C.partecipanti > (
			SELECT COUNT(*)
				FROM Prenotazione
					WHERE Prenotazione.classeRIF = C.classeID 
									)
		GROUP BY nome, giorno, orario, partecipanti
		ORDER BY COUNT(*);

--15.	Recupera l'elenco dei membri che hanno annullato una prenotazione negli ultimi 30 giorni.

SELECT *
	FROM Membro
	JOIN Prenotazione ON Membro.membroID = Prenotazione.membroRIF
	WHERE  DATEADD(day, 30, Prenotazione.data_annullamento) > FORMAT(GetDate(), 'yyyy-MM-dd')
			AND YEAR(Prenotazione.data_annullamento) = YEAR(GETDATE());		-- sono sicuro che è dell'anno corrente

	--SELECT *						CURRENT_DATE torna necessariamente il TIME mentre prenotazione è in DATE
	--FROM Membro
	--JOIN Prenotazione ON Membro.membroID = Prenotazione.membroRIF
	--WHERE  DATEADD(day, 30, Prenotazione.data_annullamento) > FORMAT(CURRENT_DATE, 'yyyy-MM-dd') ; ????????

--16.	Recupera tutte le attrezzature acquistate prima del 2022.

SELECT *
FROM Attrezzo
WHERE Attrezzo.data_acquisto < '2022-01-01';


--17.	Recupera l'elenco dei membri che hanno prenotato una classe in cui l'istruttore è "Mario Rossi".

SELECT Membro.nome AS Nome, Membro.cognome AS Cognome
	FROM Membro
	JOIN Prenotazione ON Membro.membroID = Prenotazione.membroRIF
	JOIN Classe ON Prenotazione.classeRIF = classeID
	JOIN Istruttore ON Classe.istruttoreRIF = istruttoreID
	WHERE Istruttore.nome = 'Mario' AND Istruttore.cognome = 'Rossi';

--18.	Calcola il numero totale di prenotazioni per ogni classe per un determinato periodo di tempo.

SELECT Classe.nome AS Nome, COUNT(data_prenotazione) AS Prenotazioni_Totali
	FROM Prenotazione
	JOIN Classe ON Prenotazione.classeRIF = Classe.classeID
	WHERE Prenotazione.data_prenotazione IN (
		SELECT Prenotazione.data_prenotazione 
			FROM Prenotazione
				GROUP BY data_prenotazione
				HAVING Prenotazione.data_prenotazione BETWEEN '2020-01-01' AND FORMAT(GetDate(), 'yyyy-MM-dd') 
												)
		GROUP BY nome
		ORDER BY COUNT(data_prenotazione)

--19.	Trova tutte le classi associate a un'istruttore specifico e i membri che vi hanno partecipato.
--DISTINCT !!! perchè voglio i corsi, non le prenotazioni ripetute per lo stesso corso
SELECT  DISTINCT Classe.classeID, Classe.nome AS Nome_Classe, Istruttore.nome + Istruttore.cognome AS Nominativo_Istruttore, Membro.nome + Membro.cognome AS Nominativo_Membro
	FROM Membro
	JOIN Prenotazione ON Membro.membroID = Prenotazione.membroRIF
	JOIN Classe ON Prenotazione.classeRIF = Classe.classeID
	JOIN Istruttore ON Classe.istruttoreRIF = Istruttore.istruttoreID
	WHERE Istruttore.istruttoreID IN (SELECT Classe.istruttoreRIF FROM Classe 
												JOIN Prenotazione ON Membro.membroID = Prenotazione.membroRIF
												JOIN Membro ON Prenotazione.membroRIF = Membro.membroID
									  ) 
								  AND data_prenotazione < FORMAT(GetDate(), 'yyyy-MM-dd');

--20.	Recupera tutte le attrezzature in manutenzione e il nome degli istruttori che le utilizzano nelle loro classi.
SELECT Attrezzo.nome AS Attrezzo, Istruttore.nome + Istruttore.cognome AS Nome_Istruttore, Classe.nome AS Classe
	FROM Attrezzo
	JOIN Classe ON Attrezzo.classeRIF = Classe.classeID
	JOIN Istruttore ON Classe.istruttoreRIF = Istruttore.istruttoreID
	WHERE Attrezzo.stato = 'In Manutenzione'

--------------------------------------------------------------------------------------------------------------------
--VIEW
--1.	Crea una view che mostra l'elenco completo dei membri con il loro nome, cognome e tipo di abbonamento.

CREATE VIEW ElencoMembri AS
	SELECT Membro.nome + ' ' + Membro.cognome AS Nome_Membro, Abbonamento.tipo AS Tipo_Abbonamento
		FROM Membro
		JOIN Abbonamento ON Membro.membroID = Abbonamento.membroRIF
		
SELECT * FROM ElencoMembri WHERE Nome_Membro = 'Mario Rossi'

--2.	Crea una view che elenca tutte le classi disponibili con i rispettivi nomi degli istruttori.

CREATE VIEW ElencoClassiDisponibili AS
	SELECT  C.nome AS Nome, giorno AS Giorno, orario AS Orario, Istruttore.nome + ' ' + Istruttore.cognome AS Nome_Istruttore,
	partecipanti - COUNT(*) AS Posti_Disponibili
		FROM Classe AS C
			JOIN Istruttore ON C.istruttoreRIF = Istruttore.istruttoreID
			WHERE C.partecipanti > (
				SELECT COUNT(*)
					FROM Prenotazione
						WHERE Prenotazione.classeRIF = C.classeID 
										)
			GROUP BY C.nome, giorno, orario, partecipanti,  Istruttore.nome + ' ' + Istruttore.cognome

SELECT * FROM ElencoClassiDisponibili

--3.	Crea una view che mostra le classi prenotate dai membri insieme al nome della classe e alla data di prenotazione.

CREATE VIEW ElencoClassiPrenotate AS
	SELECT M.nome + ' ' + M.cognome AS Membro, C.nome As Classe, P.data_prenotazione AS Prenotazione
		FROM Membro AS M
		JOIN Prenotazione AS P ON M.membroID = P.membroRIF
		JOIN Classe AS C ON P.classeRIF = C.classeID

SELECT * FROM ElencoClassiPrenotate

--4.	Crea una view che elenca tutte le attrezzature attualmente disponibili, con la descrizione e lo stato.

CREATE VIEW ElencoAttrezzatureDisponibili AS
	SELECT A.nome AS Nome, A.descrizione AS Descrizione, A.stato AS Stato
		FROM Attrezzo AS A
		WHERE A.stato != 'In Manutenzione' AND A.stato != 'Fuori Servizio'

SELECT * FROM ElencoAttrezzatureDisponibili;

--5.	Crea una view che mostra i membri che hanno prenotato una classe di spinning negli ultimi 30 giorni.

CREATE VIEW ElencoMembriPrenotazioneSpinning30Giorni AS
	SELECT M.nome + ' ' + M.cognome AS Membro, C.nome AS Classe, P.data_prenotazione AS Data
		FROM Membro AS M
		JOIN Prenotazione AS P ON M.membroID = P.membroRIF
		JOIN Classe AS C ON P.classeRIF = C.classeID
		WHERE C.nome = 'Spinning' 
				AND DATEADD(DAY, -30, P.data_prenotazione) <= '2024-09-20'
				AND YEAR(P.data_prenotazione) = YEAR(GETDATE());


SELECT * FROM ElencoMembriPrenotazioneSpinning30Giorni;

--6.	Crea una view che elenca gli istruttori con il numero totale di classi che conducono.

CREATE VIEW ElencoIstruttoriNumeroClassi AS
	SELECT I.nome + ' ' + I.cognome AS Nome_Istruttore, COUNT(*) AS Classi_Condotte
		FROM Istruttore AS I
		JOIN Classe AS C ON I.istruttoreID = C.istruttoreRIF
		WHERE C.istruttoreRIF = I.istruttoreID
		GROUP BY I.nome, I.cognome;

SELECT * FROM ElencoIstruttoriNumeroClassi;

--7.	Crea una view che mostri il nome delle classi e il numero di partecipanti registrati per ciascuna classe.

CREATE VIEW ElencoClassiPartecipantiRegistrati AS
	SELECT C.nome AS Nome_Classe, COUNT(*) AS Partecipanti_Registrati
		FROM Classe AS C
		JOIN Prenotazione AS P ON C.classeID = P.classeRIF
		JOIN Membro AS M ON P.membroRIF = M.membroID
		GROUP BY C.nome

SELECT * FROM ElencoClassiPartecipantiRegistrati;

--8.	Crea una view che elenca i membri che hanno un abbonamento attivo insieme alla data di inizio e la data di scadenza.

CREATE VIEW ElencoMebriAbbonamentoAttivo AS
	SELECT M.nome + ' ' + M.cognome AS Membro,A.tipo AS Tipo_abbonamento, A.inizio_abbonamento AS Inizio_abbonamento, A.fine_abbonamento AS Fine_abbonamento
		FROM Membro AS M
		JOIN Abbonamento AS A ON M.membroID = A.membroRIF
		WHERE 
			(A.tipo = 'Mensile' AND DATEADD(month, 1, A.inizio_abbonamento) >= GETDATE()) OR
			(A.tipo = 'Trimestrale' AND DATEADD(month, 3, A.inizio_abbonamento) >= GETDATE()) OR
			(A.tipo = 'Annuale' AND DATEADD(year, 1, A.inizio_abbonamento) >= GETDATE());

SELECT * FROM ElencoMebriAbbonamentoAttivo;

--9.	Crea una view che mostra l'elenco degli istruttori che conducono classi il lunedì e il venerdì.

CREATE VIEW ElencoIstruttoriClassiLunediVenerdi AS
	SELECT I.nome + ' ' + I.cognome AS Istruttore, C.nome AS Classe
		FROM Istruttore AS I
		JOIN Classe AS C ON I.istruttoreID = C.istruttoreRIF
			WHERE C.giorno IN ('Lunedì', 'Venerdì');

SELECT * FROM ElencoIstruttoriClassiLunediVenerdi;


--10.	Crea una view che elenca tutte le attrezzature acquistate nel 2023 insieme al loro stato attuale.

CREATE VIEW ElencoAttrezzature2023 AS
	SELECT A.nome AS Attrezzo, A.data_acquisto AS Data_Acquisto, A.stato AS Stato
		FROM Attrezzo AS A
		WHERE A.data_acquisto BETWEEN '2023-01-01' AND '2023-12-31';

SELECT * FROM ElencoAttrezzature2023;

-----------------------------------------------------------------------------------
--SP

--1.	Scrivi una stored procedure che permette di inserire un nuovo membro
--		nel sistema con tutti i suoi dettagli, come nome, cognome, data di nascita, tipo di abbonamento, ecc.


CREATE PROCEDURE InsertMembro
	@Nom VARCHAR(250),
	@Cog VARCHAR(250),
	@Dat DATE,
	@Ses VARCHAR(250),
	@Ema VARCHAR(250),
	@Tel INT
AS
BEGIN
		BEGIN
			INSERT INTO Membro(nome,cognome, data_nascita, sesso, email, telefono) VALUES
			(@Nom, @Cog, @Dat, @Ses, @Ema, @Tel);
		END
END;

EXEC InsertMembro @Nom = 'Giovanni', @Cog = 'Pax', @Dat = '1989-01-01', @Ses = 'Maschio', @Ema = 'gio@pace.com', @Tel = 3337776;

SELECT * FROM Membro


--2.	Scrivi una stored procedure per aggiornare lo stato di un'attrezzatura 
--		(ad esempio, disponibile, in manutenzione, fuori servizio).

CREATE PROCEDURE UpdateStatus
	@NuovoStatus VARCHAR(250),
	@AttrezzoID INT
AS
BEGIN
		BEGIN
			UPDATE Attrezzo
			SET stato = @NuovoStatus
			WHERE attrezzoID = @AttrezzoID;
		END
END;

SELECT * FROM Attrezzo;

EXEC UpdateStatus @NuovoStatus = 'Fuori Servizio', @AttrezzoID = 1;
EXEC UpdateStatus @NuovoStatus = 'Disponibile', @AttrezzoID = 1;



--3.	Scrivi una stored procedure che consenta a un membro di prenotare una classe specifica.
--		Questi dati devono essere noti a priori

CREATE PROCEDURE PrenotazioneClasse
	@ClasseID INT,
	@MembroID INT
AS
BEGIN
		BEGIN
			INSERT INTO Prenotazione (data_prenotazione, membroRIF, classeRIF) VALUES 
			('2025-09-20', @MembroID, @ClasseID)
		END
END;

SELECT * FROM Membro;
SELECT * FROM Prenotazione;

EXEC PrenotazioneClasse @ClasseID = 2, @MembroID = 1;

--4.	sql


--5.	Scrivi una stored procedure per permettere ai membri di cancellare una prenotazione esistente.

CREATE PROCEDURE CancellaPrenotazione
	@PrenotazioneID INT,
	@MembroID INT
AS
BEGIN
		BEGIN
			UPDATE Prenotazione
			SET data_annullamento = FORMAT(GetDate(), 'yyyy-MM-dd')
			WHERE Prenotazione.membroRIF = @MembroID AND Prenotazione.prenotazioneID = @PrenotazioneID;
		END
END;

SELECT * FROM Prenotazione;
EXEC CancellaPrenotazione @PrenotazioneID = 10, @MembroID = 1;

--6.	Scrivi una stored procedure che restituisce il numero di classi condotte da un istruttore specifico.

CREATE PROCEDURE ClassiIstruttore
	@IstruttoreID INT
AS
BEGIN
		BEGIN
				SELECT COUNT(*) AS Classi_Condotte
				FROM Classe AS C
				WHERE C.istruttoreRIF = @IstruttoreID;
		END
END;

SELECT * FROM Istruttore
SELECT * FROM Classe
EXEC ClassiIstruttore @IstruttoreID = 5;