int[][] now; // aktueller Zustand des Spielfeldes
int[][] then; // nächster Zustand des Spielfeldes

int MAXV = 80; // dann gibt es pro Zeile/Spalte die Felder 0 bis MAXV-1
int FSIZE = 8; // Größe eines Feldes in Pixeln

int i; // oft benutzte Zähl-
int j; // variablen

void setup()
{
	size(640, 640); // das Spielfeld ist quadratisch
	//noStroke();
	now = new int[MAXV][MAXV];
	then = new int[MAXV][MAXV];
	initialisiere_Spielfeld();
}

// ----------------------------------------------------

void initialisiere_Spielfeld() // hier wird das Spielfeld gefüllt,
{                              // wie auch immer -> EDITIEREN
	for(int i = 0; i < 20; i++) {
		now[(int) random(0, MAXV)][(int) random(0, MAXV)] = floor(random(1, 5));
	}
}

// ----------------------------------------------------

void draw() // Zeichenroutine, normalerweise nicht editieren
{
	for (i = 0; i < MAXV; i++)
	{
		for (j = 0; j < MAXV; j++)
		{
			zeichne_ein_Feld(i, j);
		}
	}
	berechne_Folgezustand();
	kopiere_um();
}

// ----------------------------------------------------

void berechne_Folgezustand() // hier steckt das Regelwerk drin -> EDITIEREN
{                            // (i. d. R. aber nur innerhalb der j-Schleife)
	now[(int) random(0, MAXV)][(int) random(0, MAXV)] = floor(random(1, 5));
	
	for (i = 0; i < MAXV; i++)
	{
		for (j = 0; j < MAXV; j++)
		{
			int me = now[i][j];
			int next_me = me;

			int neighbor_a = now[kkw(i-1)][kkw(j)];
			int neighbor_w = now[kkw(i)][kkw(j-1)];
			int neighbor_d = now[kkw(i+1)][kkw(j)];
			int neighbor_x = now[kkw(i)][kkw(j+1)];

			if(me == 0 || me >= 5) // schwarz
			{
				if(neighbor_a == 1)
					next_me = 1;

				if(neighbor_d == 2)
					next_me = 2;

				if(neighbor_x == 3)
					next_me = 3;

				if(neighbor_w == 4)
					next_me = 4;
			}
			else if(me == 1) // rot
			{
				next_me = 5;
			}
			else if(me == 2) // blau
			{
				next_me = 5;
			}
			else if(me == 3) // gelb
			{
				next_me = 5;
			}
			else if(me == 4) // grün
			{
				next_me = 5;
			}
			else if(me >= 20)
			{
				next_me = 0;
			}
			else if(me >= 5)
			{
				next_me = me+1;
			}
			

			then[i][j] = next_me;
		}
	}
}

int countNeighbours(int i, int j)
{
	int nachbarn = 0;
	
	for(int a = 0; a < 3; a++) {
		for(int b = 0; b < 3; b++) {
			if (!(a == 1 && b == 1)) {
				nachbarn += feldwert(i+a-1, j+b-1);
			}
		}
	}
	
	return nachbarn;
}

// ----------------------------------------------------

void zeichne_ein_Feld(int x0, int y0) // wie ein Feld sich mit
{                                              // seinem Wert darstellt -> EDITIEREN
	if (now[x0][y0] == 0)
	{
		fill(0);
		rect(x0*FSIZE,y0*FSIZE,FSIZE,FSIZE);
	}
	else if (now[x0][y0] == 1)
	{
		fill(255, 0, 0);
		rect(x0*FSIZE,y0*FSIZE,FSIZE,FSIZE);
	}
	else if (now[x0][y0] == 2)
	{
		fill(0, 0, 255);
		rect(x0*FSIZE,y0*FSIZE,FSIZE,FSIZE);
	}
	else if (now[x0][y0] == 3)
	{
		fill(255, 255, 0);
		rect(x0*FSIZE,y0*FSIZE,FSIZE,FSIZE);
	}
	else if (now[x0][y0] == 4)
	{
		fill(0, 255, 0);
		rect(x0*FSIZE,y0*FSIZE,FSIZE,FSIZE);
	}
	else if (now[x0][y0] >= 5)
	{
		fill(127-now[x0][y0]*6);
		rect(x0*FSIZE,y0*FSIZE,FSIZE,FSIZE);
	}
}

// ----------------------------------------------------

void kopiere_um() // die Umkopier-Routine -> nicht editieren
{
	for (i = 0; i < MAXV; i++)
	{
		for (j = 0; j < MAXV; j++)
		{
			now[i][j] = then[i][j];
		}
	}
}

// ----------------------------------------------------

int feldwert(int fx, int fy) // liefert den Wert eine Feldes, korrigiert dabei 
{                            // mit der kkw-Funktion ungültige Koordinaten
	fx = kkw(fx);
	fy = kkw(fy);
	return now[fx][fy];
}

// ----------------------------------------------------

int kkw(int koordinatenwert) // korrigiert einen Koordinatenwert ("faltet die Welt um") -> nicht editieren
{
	if (koordinatenwert < 0)
	{
		return kkw(koordinatenwert + MAXV);
	}
	else if (koordinatenwert >= MAXV)
	{
		return kkw(koordinatenwert - MAXV);
	}
	else
	{
		return koordinatenwert;
	}
}