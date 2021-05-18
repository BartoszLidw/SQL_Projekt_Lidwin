-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 18 Maj 2021, 15:01
-- Wersja serwera: 10.4.18-MariaDB
-- Wersja PHP: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `samoloty`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `createLogTable` (IN `tblName` VARCHAR(6), IN `lot` CHAR(4), IN `lot2` CHAR(4), IN `pilot` INT(11), IN `samolot` CHAR(4), IN `data` INT, IN `czas` INT)  BEGIN
Insert into przelot VALUES (tblName, lot, lot2, pilot, samolot,data,czas);
    SET @tableName = tblName;
    SET @q = CONCAT('\r\n        CREATE TABLE IF NOT EXISTS `' , @tableName, '` (\r\n            `id_pasazer` INT(11) UNSIGNED NOT NULL) ENGINE=MyISAM DEFAULT CHARSET=utf8');
    PREPARE stmt FROM @q;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loty_w_okresie` (IN `od` DATE, IN `do` DATE)  SELECT * FROM wszystko WHERE od < wszystko.data_wylot and do > wszystko.data_wylot ORDER by wszystko.data_wylot$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `wyswietlenie_pasazerow` (IN `nazwa` CHAR(6))  BEGIN
set @witamy = nazwa;
SET @q = CONCAT('SELECT CONCAT(pasazer.imie, pasazer.nazwisko) as czlowiek  FROM ' , @witamy ,' ,pasazer WHERE ', @witamy,'.id_pasazer = pasazer.id_pasazer');
 PREPARE stmt FROM @q;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `baza_samolotow`
--

CREATE TABLE `baza_samolotow` (
  `id_samolotu` varchar(4) COLLATE utf8_polish_ci NOT NULL,
  `id_rodzaju` int(11) NOT NULL,
  `id_lini` char(4) COLLATE utf8_polish_ci NOT NULL,
  `data_przegladu` date NOT NULL,
  `dostepny` enum('tak','nie') COLLATE utf8_polish_ci NOT NULL DEFAULT 'nie'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `baza_samolotow`
--

INSERT INTO `baza_samolotow` (`id_samolotu`, `id_rodzaju`, `id_lini`, `data_przegladu`, `dostepny`) VALUES
('L123', 1, 'LOT', '2021-05-02', 'tak');

--
-- Wyzwalacze `baza_samolotow`
--
DELIMITER $$
CREATE TRIGGER `zmiana_na _duze` BEFORE INSERT ON `baza_samolotow` FOR EACH ROW set new.id_samolotu = upper(new.id_samolotu)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `dostepne_samoloty`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `dostepne_samoloty` (
`id_samolotu` varchar(4)
,`samolot` varchar(36)
,`nazwa` char(24)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `dostepne_samoloty_v2`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `dostepne_samoloty_v2` (
`id_samolotu` varchar(4)
,`samolot` varchar(39)
,`nazwa` char(24)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `linie_lotnicze`
--

CREATE TABLE `linie_lotnicze` (
  `id_lini` char(4) COLLATE utf8_polish_ci NOT NULL,
  `nazwa` char(24) COLLATE utf8_polish_ci NOT NULL,
  `kraj` char(24) COLLATE utf8_polish_ci NOT NULL,
  `sojusz` char(24) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `linie_lotnicze`
--

INSERT INTO `linie_lotnicze` (`id_lini`, `nazwa`, `kraj`, `sojusz`) VALUES
('LOT', 'LOT', 'Polska', 'Star Allianc'),
('SAS', 'Scandynavian', 'Szwecja', 'Star Allianc');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lotnisko`
--

CREATE TABLE `lotnisko` (
  `id_lotnisko` char(4) COLLATE utf8_polish_ci NOT NULL,
  `kraj` char(18) COLLATE utf8_polish_ci NOT NULL,
  `miasto` char(18) COLLATE utf8_polish_ci NOT NULL,
  `nazwa` char(24) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `lotnisko`
--

INSERT INTO `lotnisko` (`id_lotnisko`, `kraj`, `miasto`, `nazwa`) VALUES
('ATLA', 'USA', 'Atlanta', 'Hartsfield'),
('BRON', 'Polska', 'Kraków', 'Bronowice'),
('CDWG', 'Francja', 'Paryż', 'de Gaulle'),
('CHOP', 'Polska', 'Warszawa', 'Chopina'),
('PEKI', 'Chiny', 'Pekin', 'Intl'),
('PTAK', 'Szwecja', 'Oslo', 'Oslo Intercontinental');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pasazer`
--

CREATE TABLE `pasazer` (
  `id_pasazer` int(6) NOT NULL,
  `imie` char(20) COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` char(20) COLLATE utf8_polish_ci NOT NULL,
  `pesel` char(11) COLLATE utf8_polish_ci NOT NULL,
  `data_urodzenia` date NOT NULL,
  `plec` enum('m','k','...') COLLATE utf8_polish_ci NOT NULL DEFAULT '...',
  `komentarz` text COLLATE utf8_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `pasazer`
--

INSERT INTO `pasazer` (`id_pasazer`, `imie`, `nazwisko`, `pesel`, `data_urodzenia`, `plec`, `komentarz`) VALUES
(100000, 'Bartosz', 'Lidwin', '00000000011', '2000-05-18', 'm', NULL),
(100001, 'Jan', 'Kowalski', '00003000011', '2002-05-23', 'm', NULL),
(100002, 'Dao', 'Hao', '31255412343', '0000-00-00', 'm', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `piloci`
--

CREATE TABLE `piloci` (
  `id_pilot` int(11) NOT NULL,
  `imie` text COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` text COLLATE utf8_polish_ci NOT NULL,
  `zatrudniony` date NOT NULL,
  `zwolniony` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `piloci`
--

INSERT INTO `piloci` (`id_pilot`, `imie`, `nazwisko`, `zatrudniony`, `zwolniony`) VALUES
(1, 'Adam', 'Małysz', '2021-05-04', NULL),
(2, 'Dariusz', 'Morawiecki', '2021-05-17', NULL);

--
-- Wyzwalacze `piloci`
--
DELIMITER $$
CREATE TRIGGER `usuniecie_pilota` BEFORE DELETE ON `piloci` FOR EACH ROW UPDATE przelot.id_pilot set przelot.id_pilot = 99999 where old.id_pilot =  przelot.id_pilot
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `przelot`
--

CREATE TABLE `przelot` (
  `id_przelot` char(6) COLLATE utf8_polish_ci NOT NULL,
  `id_lotnisko_wylot` varchar(4) COLLATE utf8_polish_ci NOT NULL,
  `id_lotnisko_przylot` varchar(4) COLLATE utf8_polish_ci NOT NULL,
  `id_pilot` int(11) NOT NULL,
  `id_samolot` varchar(4) COLLATE utf8_polish_ci NOT NULL,
  `data_wylot` date NOT NULL,
  `czas_lotu` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `przelot`
--

INSERT INTO `przelot` (`id_przelot`, `id_lotnisko_wylot`, `id_lotnisko_przylot`, `id_pilot`, `id_samolot`, `data_wylot`, `czas_lotu`) VALUES
('uasq', 'CHOP', 'BRON', 1, 'L123', '2021-05-03', '01:27:06'),
('zupa', 'ATLA', 'PTAK', 2, 'L123', '0000-00-00', '00:00:08');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rodzaj_samolotu`
--

CREATE TABLE `rodzaj_samolotu` (
  `id_rodzaju` int(4) NOT NULL,
  `nazwa` varchar(18) COLLATE utf8_polish_ci NOT NULL,
  `model` varchar(18) COLLATE utf8_polish_ci NOT NULL,
  `pojemnosc` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `rodzaj_samolotu`
--

INSERT INTO `rodzaj_samolotu` (`id_rodzaju`, `nazwa`, `model`, `pojemnosc`) VALUES
(1, 'kaczuszka', '420', 3),
(2, 'Sanok s.a', 'nocna', 7),
(3, 'AGH', 'latawiec', 2),
(4, 'Boing', 'NotHorny', 69);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uasq`
--

CREATE TABLE `uasq` (
  `id_pasazer` int(11) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `uasq`
--

INSERT INTO `uasq` (`id_pasazer`) VALUES
(100000),
(100001),
(100002);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `wszystko`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `wszystko` (
`lotnisko_wylot` varchar(24)
,`lotnisko_przylot` varchar(24)
,`pilot` mediumtext
,`samolot` varchar(18)
,`wlasciciel` char(24)
,`data_wylot` date
,`czas_lotu` time
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zupa`
--

CREATE TABLE `zupa` (
  `id_pasazer` int(11) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura widoku `dostepne_samoloty`
--
DROP TABLE IF EXISTS `dostepne_samoloty`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dostepne_samoloty`  AS SELECT `baza_samolotow`.`id_samolotu` AS `id_samolotu`, concat(`rodzaj_samolotu`.`nazwa`,`rodzaj_samolotu`.`model`) AS `samolot`, `linie_lotnicze`.`nazwa` AS `nazwa` FROM ((`baza_samolotow` join `rodzaj_samolotu` on(`rodzaj_samolotu`.`id_rodzaju` = `baza_samolotow`.`id_rodzaju`)) join `linie_lotnicze` on(`linie_lotnicze`.`id_lini` = `baza_samolotow`.`id_lini`)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `dostepne_samoloty_v2`
--
DROP TABLE IF EXISTS `dostepne_samoloty_v2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dostepne_samoloty_v2`  AS SELECT `baza_samolotow`.`id_samolotu` AS `id_samolotu`, concat(`rodzaj_samolotu`.`nazwa`,' - ',`rodzaj_samolotu`.`model`) AS `samolot`, `linie_lotnicze`.`nazwa` AS `nazwa` FROM ((`baza_samolotow` join `rodzaj_samolotu` on(`rodzaj_samolotu`.`id_rodzaju` = `baza_samolotow`.`id_rodzaju`)) join `linie_lotnicze` on(`linie_lotnicze`.`id_lini` = `baza_samolotow`.`id_lini`)) WHERE `baza_samolotow`.`dostepny` = 'tak' ;

-- --------------------------------------------------------

--
-- Struktura widoku `wszystko`
--
DROP TABLE IF EXISTS `wszystko`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wszystko`  AS SELECT coalesce(`a`.`miasto`,`a`.`nazwa`) AS `lotnisko_wylot`, coalesce(`b`.`miasto`,`b`.`nazwa`) AS `lotnisko_przylot`, coalesce(`piloci`.`imie`,`piloci`.`nazwisko`) AS `pilot`, coalesce(`rodzaj_samolotu`.`nazwa`,`rodzaj_samolotu`.`model`) AS `samolot`, `linie_lotnicze`.`nazwa` AS `wlasciciel`, `przelot`.`data_wylot` AS `data_wylot`, `przelot`.`czas_lotu` AS `czas_lotu` FROM ((((((`przelot` join `lotnisko` `a` on(`przelot`.`id_lotnisko_wylot` = `a`.`id_lotnisko`)) join `lotnisko` `b` on(`przelot`.`id_lotnisko_przylot` = `b`.`id_lotnisko`)) join `piloci` on(`przelot`.`id_pilot` = `piloci`.`id_pilot`)) join `baza_samolotow` on(`przelot`.`id_samolot` = `baza_samolotow`.`id_samolotu`)) join `rodzaj_samolotu` on(`baza_samolotow`.`id_rodzaju` = `rodzaj_samolotu`.`id_rodzaju`)) join `linie_lotnicze` on(`baza_samolotow`.`id_lini` = `linie_lotnicze`.`id_lini`)) ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `baza_samolotow`
--
ALTER TABLE `baza_samolotow`
  ADD PRIMARY KEY (`id_samolotu`),
  ADD KEY `id_rodzaju` (`id_rodzaju`),
  ADD KEY `id_lini` (`id_lini`);

--
-- Indeksy dla tabeli `linie_lotnicze`
--
ALTER TABLE `linie_lotnicze`
  ADD PRIMARY KEY (`id_lini`);

--
-- Indeksy dla tabeli `lotnisko`
--
ALTER TABLE `lotnisko`
  ADD PRIMARY KEY (`id_lotnisko`);

--
-- Indeksy dla tabeli `pasazer`
--
ALTER TABLE `pasazer`
  ADD PRIMARY KEY (`id_pasazer`);

--
-- Indeksy dla tabeli `piloci`
--
ALTER TABLE `piloci`
  ADD PRIMARY KEY (`id_pilot`);

--
-- Indeksy dla tabeli `przelot`
--
ALTER TABLE `przelot`
  ADD KEY `id_lotnisko_wylot` (`id_lotnisko_wylot`),
  ADD KEY `id_lotnisko_przylot` (`id_lotnisko_przylot`),
  ADD KEY `id_pilot` (`id_pilot`),
  ADD KEY `id_samolot` (`id_samolot`);

--
-- Indeksy dla tabeli `rodzaj_samolotu`
--
ALTER TABLE `rodzaj_samolotu`
  ADD PRIMARY KEY (`id_rodzaju`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `pasazer`
--
ALTER TABLE `pasazer`
  MODIFY `id_pasazer` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100003;

--
-- AUTO_INCREMENT dla tabeli `piloci`
--
ALTER TABLE `piloci`
  MODIFY `id_pilot` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `rodzaj_samolotu`
--
ALTER TABLE `rodzaj_samolotu`
  MODIFY `id_rodzaju` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `baza_samolotow`
--
ALTER TABLE `baza_samolotow`
  ADD CONSTRAINT `baza_samolotow_ibfk_1` FOREIGN KEY (`id_rodzaju`) REFERENCES `rodzaj_samolotu` (`id_rodzaju`),
  ADD CONSTRAINT `baza_samolotow_ibfk_2` FOREIGN KEY (`id_lini`) REFERENCES `linie_lotnicze` (`id_lini`);

--
-- Ograniczenia dla tabeli `przelot`
--
ALTER TABLE `przelot`
  ADD CONSTRAINT `przelot_ibfk_1` FOREIGN KEY (`id_lotnisko_wylot`) REFERENCES `lotnisko` (`id_lotnisko`),
  ADD CONSTRAINT `przelot_ibfk_2` FOREIGN KEY (`id_lotnisko_przylot`) REFERENCES `lotnisko` (`id_lotnisko`),
  ADD CONSTRAINT `przelot_ibfk_3` FOREIGN KEY (`id_pilot`) REFERENCES `piloci` (`id_pilot`),
  ADD CONSTRAINT `przelot_ibfk_4` FOREIGN KEY (`id_samolot`) REFERENCES `baza_samolotow` (`id_samolotu`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
