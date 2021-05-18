#include <mysql.h>
#include <iostream>
#include <sstream>

using namespace std;
int qstate;
MYSQL* conn;
MYSQL_ROW row;
MYSQL_RES* res;

//INSERTS
void pusto()
{
	cout << "pusto \n";
}
void zatrudnij_pilota()
{
	SYSTEMTIME st;
	GetSystemTime(&st);

	string ime, nazwisko;
	cout << "Wprowadz imie pilota: \n";
	getline(cin >> ws, ime);
	cout << "Wprowadz nazwisko pilota: \n";
	getline(cin >> ws, nazwisko);

	stringstream ss;
	ss << "insert into piloci (imie, nazwisko, zatrudniony) values ('" << ime << "', '" << nazwisko << "', '" << st.wYear << "-" << st.wMonth << "-" << st.wDay << "')";

	string q = ss.str();
	cout << q;
	const char* query = q.c_str();
	if (mysql_query(conn, q.c_str()) >= 0) {
		cout << "Dodano";
	}
	else {
		cout << "Cos poszlo nie tak";
	}
}
void zaluz_konto()
{
	int i;
	string imie, nazwisko, pesel, data, plec;
	cout << "Wprowadz imie: \n";
	getline(cin >> ws, imie);
	cout << "Wprowadz nazwisko: \n";
	getline(cin >> ws, nazwisko);
	cout << "Wprowadz PESEL: \n";
	getline(cin >> ws, pesel);
	cout << "Wprowadz date urodzenia w systemie rrrr-mm-dd: \n";
	getline(cin >> ws, data);
	cout << "Wybierz plec: \n 1 -> m \n 2 -> k \n ";
	cin >> i;

	if (i == 1)
	{
		plec = "m";
	}
	else if (i == 2)
	{
		plec = "k";
	}
	else
	{
		plec = "...";
	}


	stringstream ss;
	ss << "insert into pasazer (imie, nazwisko, pesel, data_urodzenia, plec) values ('" << imie << "', '" << nazwisko << "', '" <<pesel<<"','"<<data<<"','"<<plec<< "')";

	string q = ss.str();
	cout << q;
	const char* query = q.c_str();
	if (mysql_query(conn, q.c_str()) >= 0) {
		cout << "Dodano";
	}
	else {
		cout << "Cos poszlo nie tak";
	}
}
void nowy_rodzaj()
{
	string id, nazwa, model;
	int pojemnosc;
	cout << "Wprowadz id dla nowego rodzaju samolotu: \n";
	getline(cin >> ws, id);
	cout << "Wprowadz nazwe producenta: \n";
	getline(cin >> ws, nazwa);
	cout << "Wprowadz model: \n ";
	getline(cin >> ws, model);
	
	do {
		cout << "Wprowadz pojemnosc: \n";
		cin >> pojemnosc;
	} 		while (pojemnosc > 300 || pojemnosc < 0);
		


	stringstream ss;
	ss << "insert into rodzaj_samolotu (id_rodzaju, nazwa, model, pojemnosc) values ('" << id << "', '"<<nazwa<<"','" << model << "', '" << pojemnosc << "')";

	string q = ss.str();
	cout << q;
	const char* query = q.c_str();
	if (mysql_query(conn, q.c_str()) >= 0) {
		cout << "Dodano\n";
	}
	else {
		cout << "Cos poszlo nie tak";
	}
}
void nowy_samolot()
{
	SYSTEMTIME st;
	GetSystemTime(&st);
	string id, id_rodzaju, id_lini, data;
	int pojemnosc;
	cout << "Wprowadz id dla nowego samolotu(4): \n";
	getline(cin >> ws, id);
	cout << "Wprowadz id rodzaju: \n";
	getline(cin >> ws, id_rodzaju);
	cout << "Wprowadz id lini lotniczej: \n ";
	getline(cin >> ws, id_lini);
	
	



	stringstream ss;
	ss << "insert into baza_samolotow (id_samolotu, id_rodzaju, id_lini, data_przegladu, dostepny) values ('" << id << "', '" << id_rodzaju << "','" << id_lini << "', '" << st.wYear << "-" << st.wMonth << "-" << st.wDay << "', 'tak')";

	string q = ss.str();
	cout << q;
	const char* query = q.c_str();
	if (mysql_query(conn, q.c_str()) >= 0) {
		cout << "Dodano\n";
	}
	else {
		cout << "Cos poszlo nie tak";
	}
}
void dodaj_lotnisko()
{
	
	string id, kraj, miasto, nazwa;
	cout << "Wprowadz id dla lotniska(4): \n";
	getline(cin >> ws, id);
	cout << "Wprowadz w jakim kraju jest lotnisko: \n";
	getline(cin >> ws, kraj);
	cout << "Wprowadz w jakim miescie: \n ";
	getline(cin >> ws, miasto);
	cout << "Wprowadz nazwe lotniska: \n ";
	getline(cin >> ws, nazwa);





	stringstream ss;
	ss << "insert into lotnisko values ('" << id << "', '" << kraj << "','" << miasto << "', '" <<nazwa << "')";

	string q = ss.str();
	cout << q;
	const char* query = q.c_str();
	if (mysql_query(conn, q.c_str()) >= 0) {
		cout << "Dodano\n";
	}
	else {
		cout << "Cos poszlo nie tak";
	}
}
void dodanie_lini_lotniczej()
{
	string id, kraj, miasto, nazwa;
	cout << "Wprowadz id dla lini(4): \n";
	getline(cin >> ws, id);
	cout << "Wprowadz w jakim kraju jest lokalizacja: \n";
	getline(cin >> ws, kraj);
	cout << "Wprowadz jak sie nazywa: \n ";
	getline(cin >> ws, miasto);
	cout << "Wprowadz nazwe sojuszu: \n ";
	getline(cin >> ws, nazwa);





	stringstream ss;
	ss << "insert into linie_lotnicze values ('" << id << "', '" << miasto << "','" << kraj << "', '" << nazwa << "')";

	string q = ss.str();
	cout << q;
	const char* query = q.c_str();
	if (mysql_query(conn, q.c_str()) >= 0) {
		cout << "Dodano\n";
	}
	else {
		cout << "Cos poszlo nie tak";
	}
}
void uzupelnanie_przelotu()
{
	string id, pesel;
	cout << "Wprowadz id przelotu: \n";
	getline(cin >> ws, id);
	cout << "Wprowadz pesel: \n";
	getline(cin >> ws, pesel);

	stringstream ss;
	ss << "insert into " << id << " select pasazer.id_pasazer from pasazer where pasazer.pesel = " << pesel;

	string q = ss.str();
	cout << q;
	const char* query = q.c_str();
	if (mysql_query(conn, q.c_str()) >= 0) {
		cout << "Dodano\n";
	}
	else {
		cout << "Cos poszlo nie tak";
	}
}
void zaplanuj_przelot()
{
	string id, miastoa, miastob, pilot, samolot, data, czas;
	cout << "Wprowadz id przelotu: \n";
	getline(cin >> ws, id);
	cout << "Wprowadz miasto z ktorego wylatuje: \n";
	getline(cin >> ws, miastoa);
	cout << "Wprowadz miasto do którego leci: \n";
	getline(cin >> ws, miastob);
	cout << "Wprowadz id pilota: \n";
	getline(cin >> ws, pilot);
	cout << "Wprowadz id samolotu: \n";
	getline(cin >> ws, samolot);
	cout << "Wprowadz date przelotu: \n";
	getline(cin >> ws, data);
	cout << "Wprowadz planowany czas przelotu (xx:xx:xx): \n";
	getline(cin >> ws, czas);

	stringstream ss;
	ss << "call createLogTable('" << id << "','" << miastoa << "','" << miastob << "','" << pilot << "','" << samolot << "','" << data << "','" << czas<<"')";

	string q = ss.str();
	cout << q;
	const char* query = q.c_str();
	if (mysql_query(conn, q.c_str()) >= 0) {
		cout << "Dodano\n";
	}
	else {
		cout << "Cos poszlo nie tak";
	}
}
//UPDATES
void zwolnienie_pilota()
{
	SYSTEMTIME st;
	GetSystemTime(&st);
	string name, nazwisko;

	cout << "Jak ma na imie pilot do zwolnienia:" << endl;
	getline(cin >> ws, name);

	cout << "A jak ma na nazwisko:" << endl;
	getline(cin >> ws, nazwisko);

	stringstream ss;

	ss << "update piloci set zwolniony ='" << st.wYear << "-" << st.wMonth << "-" << st.wDay << "' where imie ='" << name << "' and nazwisko = '"<< nazwisko<<"'";
	string q = ss.str();
	cout << q;
	const char* query = q.c_str();
	mysql_query(conn, query);
	cout << "Updated" << endl;
}
//DELETES
void wyrzucenie_samolotu()
{
	string id;
	cout << "to jakie id ma samolot do usuniecia z uzytku: " << endl;
	cin >> id;
	string query = "delete from baza_samolotow where id_samolotu=" + id;
	mysql_query(conn, query.c_str());
	cout << "Deleted" << endl;
}
//READ
void wyszystkie_przeloty()
{
	string query = "SELECT * FROM wszystko";
	const char* q = query.c_str();
	qstate = mysql_query(conn, q);
	if (!qstate)
	{
		res = mysql_store_result(conn);
		while (row = mysql_fetch_row(res))
		{
			cout << "Wylot: " << row[0] << " Przylot: " << row[1] << " Pilot: " << row[2] << " samolot: " << row[3] << " Wlasciciel: " << row[4] << " data wylotu: " << row[5] << " czas lotu: " << row[6] << endl;

		}
	}
}
void przeloty_w_ograniczonym_okersie()
{
	string data1, data2;
	cout << "Wprowadz date urodzenia w systemie rrrr-mm-dd: \n";
	getline(cin >> ws, data1);
	cout << "Wprowadz date urodzenia w systemie rrrr-mm-dd: \n";
	getline(cin >> ws, data2);

	string query = "call loty_w_okresie('"+data1+"','"+data2+"')";
	const char* q = query.c_str();
	qstate = mysql_query(conn, q);
	if (!qstate)
	{
		res = mysql_store_result(conn);
		while (row = mysql_fetch_row(res))
		{
			cout << "Wylot: " << row[0] << " Przylot: " << row[1] << " Pilot: " << row[2] << " samolot: " << row[3] << " Wlasciciel: " << row[4] << " data wylotu: " << row[5] << " czas lotu: " << row[6] << endl;

		}
	}
}
void dostepne_samoloty()
{
	string query = "SELECT * FROM dostepne_samoloty_v2";
	const char* q = query.c_str();
	qstate = mysql_query(conn, q);
	if (!qstate)
	{
		res = mysql_store_result(conn);
		while (row = mysql_fetch_row(res))
		{
			cout << "id samolotu: " << row[0] << " samolot : " << row[1] << " nazwa: " <<row[2] << endl;

		}
	}
}
void lista()
{
	string lot_id;
	cout << "Wprowadz id lotu \n";
	getline(cin >> ws, lot_id);
	string query = "call wyswietlenie_pasazerow('" + lot_id + "')";
	const char* q = query.c_str();
	qstate = mysql_query(conn, q);
	if (!qstate)
	{
		res = mysql_store_result(conn);
		cout << "lista: \n";
		while (row = mysql_fetch_row(res))
		{
			cout << row[0] << endl;

		}
	}
}
void napisz_sam()
{
	string query;
	getline(cin >> ws, query);
	
	const char* q = query.c_str();
	qstate = mysql_query(conn, q);
	if (!qstate)
	{
		res = mysql_store_result(conn);
		cout << "lista: \n";
		while (row = mysql_fetch_row(res))
		{
			int length = sizeof(row) / sizeof(MYSQL_RES*);
				for (int i = 0; i < length; i++)
				{
					cout << row[i];
				}

		}
	}
}
int main()
{
	int n, f;
	conn = mysql_init(0);
	conn = mysql_real_connect(conn, "localhost", "root", "", "samoloty", 3306, NULL, 0);

	if (conn) {
		puts("Successful connection to database!");
		
		while (true) {
			cout << "Co robimy teraz: \n";
			cout << "odzczytanie danych -> 1 \n";
			cout << "dadawanie obiektu -> 2 \n";
			cout << "zwolnic pilota -> 3 \n";
			cout << "usunac obiekt -> 4 \n";
			cin >> f;
			if (f == 1)
			{
				cout << "To jakie dane chcesz zobaczyæ: \n";
				cout << "wszystkie w przeloty -> 1 \n";
				cout << "przeloty ograniczone datami -> 2 \n";
				cout << "wszystkie samoloty -> 3 \n";
				cout << "pasazera w danym przelocie -> 4 \n";
				cin >> n;
				if (n == 1)
				{
					wyszystkie_przeloty();
				}
				if (n == 2)
				{
					przeloty_w_ograniczonym_okersie();
				}
				if (n == 3)
				{
					dostepne_samoloty();
				}
				if (n == 4)
				{
					lista();
				}
			}
			if (f == 2)
			{
				cout << "To jaki obiekt chcesz dodac: \n";
				cout << "pilot -> 1 \n";
				cout << "pasazer -> 2 \n";
				cout << "rodzaj samolotu -> 3 \n";
				cout << "samolot -> 4 \n";
				cout << "lotnisko -> 5 \n";
				cout << "linia lotnicza -> 6 \n";
				cout << "pasazera do przelotu -> 7 \n";
				cout << "przelot !pozor -> 8 \n";
				cin >> n;
				if (n == 1)
				{
					zatrudnij_pilota();
				}
				if (n == 2)
				{
					zaluz_konto();
				}
				if (n == 3)
				{
					nowy_rodzaj();
				}
				if (n == 4)
				{
					nowy_samolot();
				}
				if (n == 5)
				{
					dodaj_lotnisko();
				}
				if (n == 6)
				{
					dodanie_lini_lotniczej();
				}
				if (n == 7)
				{
					uzupelnanie_przelotu();
				}
				if (n == 8)
				{
					zaplanuj_przelot();
				}
			}
			if (f == 3)
			{
				zwolnienie_pilota();
			}
			if (f == 4)
			{
				wyrzucenie_samolotu();
			}
		}
	}
	else {
		puts("Connection to database has failed!");
	}

	return 0;
}