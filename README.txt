Linguaggi di Programmazione
AA 2016-2017
Gennaio 2017 Progetto E1P

Polinomi Multivariati

Briola Antonio (806906)

15 Gennaio 2017

INTRODUZIONE:

Il progetto E1P, sviluppato congiuntamente da Bernori Nicolò (matr. 807060) e Briola Antonio (matr. 806906), consiste nello sviluppo di una libreria nel linguaggio Prolog e una nel dialetto Common-Lisp atta alla manipolazione di polinomi multivariati.

Lo sviluppo di entrambe le librerie è rigorosamente fedele alle direttive riportate nell' ultima traccia rilasciata. Numerosi dubbi sono sorti in fase di sviluppo e gran parte di essi sono stati affrontati nell' apposito forum. Non ci è stato tuttavia sicuramente possibile prendere visione di ognuno di essi; di qui la scelta di seguire in maniera pedissequa tutto e solo quanto riportato nella traccia ufficiale.

FUNZIONI PRESENTI NELLA LIBRERIA SVILUPPATA IN Common Lisp:

1) Function is-monomial Monomial -> T/NIL

Il codice della funzione "is-monomial", parzialmente fornito nella traccia, è stato rafforzato in modo tale da contemplare tutte le possibili "forme" in cui un monomio possa eventualmente presentarsi.

In particolare:

-	Si è verificato che nel caso fosse passato in input un monomio nullo, il grado totale specificato sia esattamente -1;
- 	Si è verificato che nel caso fosse passato in input un intero, il grado totale specificato sia 	esattamente 0;
- 	Si è verificato che ogni tipo di monomio passato in input rispetti una struttura di questo tipo:

										(m coefficient total-degree ((v exponent variable) (vp2) É))

In definitiva suddetta funzione accetta in input una struttura di tipo monomio nella forma sopra mostrata e la valutazione di questo restituisce un valore di verità.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

2) Function monomial-degree Monomial -> TotalDegree

La funzione "monomial-degree" ha il compito di eseguire una serie di test sulla struttura monomio ricevuta in input al fine di accertarne la correttezza e la natura e quindi restituire il suo grado totale. 

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

3) Function e-list-sum List -> Value

La funzione "e-list-sum" è una funzione ausiliaria della funzione "sum-of-degrees". Riceve in input una lista (ad un singolo livello) di interi e li somma fra loro.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

4) Function sum-of-degrees List -> Value

La funzione "sum-of-degrees" è una funzione ausiliaria di "monomial-degree". Riceve in input una lista completa delle variabili e dei rispettivi esponenti presenti in un monomio e restituisce la somma degli esponenti.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

5) Function varpowers Monomial -> VP-list

La funzione "varpowers" riceve in input un monomio (può essere sia in forma parsata, sia in forma non parsata) e ritorna la lista completa delle variabili e rispettivi esponenti (qualora presenti).

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

6) Function one-level List -> New_list

La funzione "one-level" è una funzione ausiliaria di molte altre funzioni presenti all' interno della libreria. Riceve in input una generica lista a più livelli e restituisce la stessa lista ridotta ad un unico livello.

Tale funzione è comunemente conosciuta con il nome di "flatten".

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

7)  Function extract-integers-from-list List -> New_list

La funzione "extract-integers-from-list" è una funzione ausiliaria della funzione "sum-of-degrees". Riceve in input una lista i cui elementi risultano essere interi e caratteri e restituisce una lista contenente i soli interi. Tale funzione esegue il proprio compito utilizzando, ancora una volta, soprattutto la ricorsione.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

8) Function is-varpower List -> T/NIL

La funzione "is-varpower" è  una funzione ausiliaria di "is-monomial". Riceve in input una lista rappresentante la struttura "variabile, esponente" e ne verifica la correttezza.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

9) Function varpower-power List -> Integer

La funzione "varpower-power" è una funzione ausiliaria di "is-varpower". Riceve in input una lista rappresentante la struttura "variabile, esponente" ed estrae l'esponente in essa contenuto.

10) Function varpower-symbol List -> String

La funzione "varpower-symbol" è una funzione ausiliaria di "is-varpower". Riceve in input una lista rappresentante la struttura "variabile, esponente" ed estrae il simbolo di variabile in essa contenuto.

11) Function vars-of Monomial -> Variables

La funzione "vars-of" riceve in input un monomio (può essere sia in forma parsata, sia in forma non parsata) e ritorna la lista delle variabili in esso contenute. 

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

12) Function work-on-list List -> List

La funzione "work-on-list" è una funzione ausiliaria di "vars-of". Riceve in input una lista i cui elementi sono a loro volta liste (ossia tutte le triple "v, esponente, variabile") ed estrae da ciascuna la variabile.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

13) Function monomial-coefficient Monomial -> Integer

La funzione "monomial-coefficient" riceve in input un monomio (può essere sia in forma parsata, sia in forma non parsata), ne verifica la correttezza ed eventualmente restituisce il coefficiente del monomio stesso.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp

14) Function is-polynomial Poly -> T/NIL

La funzione "is-polynomial" riceve in input una struttura di tipo polinomio e verifica la correttezza  di tale struttura.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

15) Function poly-monomials Poly -> List

La funzione "poly-monomials" è una funzione ausiliaria di "is-polynomial". Riceve in input un polinomio e restituisce la lista di tutti i monomi che lo costitiuiscono.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

16) Function coefficients Poly -> Coefficients

La funzione "coefficients" riceve in input un polinomio, verifica la correttezza della sua struttura e, in caso affermativo, ritorna una lista(priva di duplicati) dei coefficienti del polinomio stesso nell'ordine esatto in cui si presentano.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

17) Function work-on-coefficient-list List -> New_List

La funzione "work-on-coefficient-list" è una funzione ausiliaria della funzione "coefficients". Riceve in input una lista di monomi e restituisce una lista contenente il coefficiente di ciascun monomio.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

18) Function variables Poly -> Variables

La funzione "variables" riceve in input un polinomio, verifica la correttezza della sua struttura e, in caso affermativo, ritorna una lista delle variabili del polinomio stesso.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

19) Function work-on-varaibles-list List -> New_List

La funzione "work-on-coefficient-list" è una funzione ausiliaria della funzione variables. Riceve in input una lista di monomi e restituisce una lista contenente le variabili di ciascun monomio.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

20) Function maxdegree Poly -> Degree

La funzione "maxdegree" riceve in input un polinomio e restituisce il più alto fra i gradi totali dei monomi che costituiscono il polinomio stesso.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

21) Function max-in-a-list List -> Integer

La funzione "max-in-a-list" è una funzione ausiliaria di maxdegree. Riceve in input una lista di interi (nel nostro caso i gradi complessivi di tutti i monomi presenti all'interno di un polinomio) e ricava il massimo valore applicando la ricorsione.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

22) Function degrees Poly -> List

La funzione "degrees" è una funzione ausiliaria delle due altre funzione "maxdegree" e "mindegree". Riceve in input un polinomio ed estrae i gradi totali di ciascun monomio presente al suo interno.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

23) Function work-on-degrees-list List -> New_List

La funzione "work-on-degrees-list" è una funzione ausiliaria della funzione "degrees". Riceve in input una lista di monomi e restituisce una lista contenente il grado totale di ciascun monomio.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

24) Function mindegree Poly -> Degree

La funzione "mindegree" riceve in input un polinomio e restituisce il più basso gra i gradi totali dei monomi che costituiscono il polinomio stesso.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

25) Function min-in-a-list List -> Integer

La funzione "min-in-a-list" è una funzione ausiliaria di mindegree. Riceve in input una lista di interi (nel nostro caso i gradi complessivi di tutti i monomi presenti all'interno di un polinomio) e ricava il minimo valore applicando la ricorsione.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

26) Function as-monomial Expression -> Monomial

La funzione "as-monomial" ritorna la struttura dati che rappresenta il monomio risultante dal "parsing" della struttura ricevuta in input. Il monomio risultante sarà chiaramente ordinato secondo le specifiche contenute nella traccia fornita.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

27) Function mul-el List -> Integer

La funzione "mul-el" è una funzione ausiliaria di "as-monomial". Riceve in input una lista di interi e li moltiplica fra loro.

28) Function sum-el List -> Integer

La funzione "sum-el" è una funzione ausiliara di "as-monomial". Riceve in input una lista di interi e li moltiplica fra loro.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

29) Function second-level-list List -> Element-of-list

La funzione "second-level-list" è una funzione ausiliaria di "as-monomial". Riceve in input una lista di un unico elemento e, nel caso la lista fosse costituita da un solo elemento, restituisce il primo elemento della stessa.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

30) Function reductio_ad_unum List -> Monomial

La funzione "reductio_ad_unum" ha l'arduo compito di assemblare la struttura parsata di un monomio. Essa riceve in input una lista e compie una serie di operazioni (minuziosamente descritte nel file .lisp) sulla stessa.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

31) Function sum-for-var List -> New_List

La funzione "sum-for-var" è una funzione ausiliaria di molte altre funzioni della libreria. Riceve in input una lista di variabili e annessi esponenti, li confronta a coppie di due, stabilisce eventuali uguaglianze ed eventualmente riduce queste ultime ad un "unicum" compatto.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

32) Function monomial-ordering Monomial -> Ordered_monomial

La funzione "monomial-ordering" riceve in input un monomio ed effettua un ordinamento della sezione "varpowers" richiamando la funzione "monomial-order".

33) Function monomial-order List -> New_list

La funzione "monomial-order" è una funzione ausiliaria di "monommial-ordering". Riceve in input una lista "varpowers", scorre ciascun elemento (lista anch'esso) e ordina in base al terzo termine, ossia in base all'ordine lessicografico delle variabili presenti.

34) Function as-polynomial Expression -> Polynomial

La funzione "as-polynomial" riceve in input una lista rappresentante un polinomio passato in forma non parsata e applica su ciascuno dei suoi componenti la funzione "as-monomial" e quindi ordinando il polinomio ottenuto.

ATTENZIONE: In caso di perplessità circa la rappresentazione del polinomio nullo consultare attentamente il lungo commento redatto in merito all'interno del file .lisp.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

35) Function poly-m-ordering Poly -> Ordered_poly_according_to_monomials

La funzione "poly-m-ordering" riceve in input un polinomio e ordina ciascun monomio al suo interno in base alle regole precedentemente viste nel commento alla funzione "monomial-ordering".

36) Function poly-ordering Poly -> Final_ordered_polynomial

La funzione "poly-ordering" riceve in input un polinomio, richiama la funzione "poly-m-ordering" passandogli in input il polinomio stesso e solo a questo punto si ha l'ordinamento finale del polinomio grazie all'utoilizzo della funzione "sort rimaneggiata" mediante la funzione "discriminate".

37) Function discriminate Monommial1 Monomial2 -> T/NIL

La funzione "discriminate" riceve in input due monomi e li confronta prima in base al grado totale e poi, in caso di parità dello stesso, in base e alle variabili e alla struttura della sezione "varpowers". In particolare, come riportato nella traccia fornita per il seguente progetto, dati due monomi del tipo:
	
	- m1: ab
	- m2: a^2

diremo innanzitutto che essi sono dotati di medesimo grado totale (2) e, in seconda istanza, che nell'ordinamento, m1 precederà m2 poichè a < a^2. E' estremamente interessante notare come questa funzione altro non sia che una versione della funzione "sort", potremmo dire, "rimaneggiata". In quanto tale essa continuerà a restituire valori di tipo booleano.

38) Function monomials Poly -> Monommials

La funzione "monomials" riceve in input un polinomio ed estrae una lista ordinata dei monomi che lo costituiscono.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

39) Function polyplus Poly1 Poly2 -> Result

La funzione "polyplus" riceve in input due polinomi e li somma fra loro.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

40) Function sum List -> New_list

La funzione "sum" è una funzione ausiliaria di "polyplus". Essa effettua la somma fra monomi adiacenti simili ricevuti in input in una lista contenente tutti i monomi che formano i polinomi fra i quali si intende effettuare la somma.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

41) Function polyminus Poly1 Poly2 -> Result

La funzione "polyminus" riceve in input due polinomi ed effettua la sottrazione. E' estremamente interessante notare che affinchè questa operazione si comporti nel modo corretto è necessario "rendere" uno dei due termini ricevuti in input, negativo. A tal fine è stata appositamente definita la funzione "mul-coefficients".

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

42) Function mul-coefficient List Integer -> Modified_list

La funzione "mul-coefficients" riceve in input due valori:

	- una lista;
	- un coefficiente moltiplicativo.

La lista rappresenta chiaramente un polinomio (costituito quindi da una serie di monomi). La funzione moltiplica ogni coefficiente di ogni monomio contenuto all'interno del polinomio ricevuto in input per il coefficiente moltiplicativo (chiaramente -1).

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

43) Function polytimes Poly1 Poly2 -> Result

La funzione "polytimes" riceve in input due polinomi e li moltiplica fra loro.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

44) Function times List1 List2 -> Result

La funzione "times" è una funzione ausiliaria della funzione "polytimes". Essa riceve in input due liste di monomi ed effettuaa l'operazione di moltiplicazione. 

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

45) Function m-times Monomial List -> Result

La funzione m-times riceve in input un monomio e una lista di monomi. Moltiplica quindi il monommio per ciascun monomio della lista e restituisce una lista contenente i monomi ottenuti mediante moltiplicazione.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

46) Function pprint-polynomial Poly -> Polynomial

La funzione "pprint-polynomial" riceve in input un polinomio in forma parsata e lo stampa a video in forma non parsata. La stampa a video è seguita, sulla stringa immediatamente successiva, dal valore NIL.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

47) Function ppprint Poly -> Polynomial

La funzione "ppprint" è una funzione ausiliaria di "pprint-polynomial". Essa riceve in input una lista di monomi ognuno dei quali nella forma parsata e richiamando ricorsivamente la funzione "monomial-tracting" su ciascuno di essi, li restituisce in forma non parsata.

Maggiori e più approfondite informazioni sono specificate nei commenti alla funzione presenti nel file .lisp.

48) Function monomial-tracting Monommial -> New_monomial

La funzione "monomial_tracting" è una funzione ausiliaria di "ppprint". Essa riceve in input un monomio in forma parsata e si occupa semplicemente di restituirlo in forma non parsata. Adempie al proprio compito inserendo nell'ambito di una lista innanzitutto il coefficiente del monomio considerato e prosegue richiamando la funzione "inter" alla quale viene passata la "varpowers" del monomio stesso.

49) Function inter Vps -> New_vps

La funzione "inter" riceve in input una "varpowers" e, richiamando la funzione "adjust-vp", e quindi ricorsivamente anche se stessa, restituisce ciascun elemento della struttura in forma non parsata.

50) Function adjust-vp Vp -> Parsed_vp

La funzione "adjust-vp" semplicemente si occupa di eseguire una forma di "parsing-inverso" e, ricevuto in input un elemento di "varpowers" lo restituisce in forma non parsata. Adempie al proprio compito semplicemente inserendo nel contesto di una lista, rispettivamente, il simbolo dell'elemento, l'apice e quindi l'esponente dell'elemento stesso.


ATTENZIONE: Purtroppo non siamo riusciti ad implementare completamente la funzione "polyval". Abbiamo tuttavia effettuato un tentativo (incompleto). Di seguito l'algoritmo pensato e il codice scritto:

	-Si effettua una sorta di "parsing inverso" della struttura polynomial ricevuta in input. Vine cioè trasformato quanto ricevuto in input come se dovesse essere stampato tramite 		 pprint-polynomial;
	- A questo punto si sostituiscono le variabili (terzo elemento di ogni componente di ciascun "varopowers", quindi con posizioni "fisse") e si valuta l'espressione ottenuta.

Ciò che ci è risultato particolarmente difficile implementare è stato appunto il passaggio della sostituzione delle variabili in "posizione fissa". Cercando sul web si sono trovate alcune possibili soluzioni ma si è scelto di non utilizzarle per ragioni "etiche" da una parte e per eccessiva complessità (utilizzo di macro) dall'altra.

; DEFINZIONE "template-replace"


(defun template-replace (template replacements)

(labels ((iterate (template)
         
	(loop :for element :in template
 
              :collect
 
              (cond ((consp element) (iterate element))
 
                    ((and
  
                     (symbolp element)
  
                     (not (equal element 'm))
 
                      (not (equal element 'p))
 
                      (not (equal element 'v))
 
                      (not (equal element 'expt))
 
                      (not (equal element '*))
  
                     (not (equal element '+)))
 
                       (pop replacements))
 
                    (t element)))))

(iterate template)))



; DEFINZIONE "polyval"
(defun polyval (p1 l1)

  (eval (template-replace (val p1 l1) l1))) 

; DEFINZIONE "val"


(defun val (p1 l1)

  (cond
 
   ((= (list-length p1) 1) (monomial-tracting1 (car p1)))

 
   (T (list '+ (monomial-tracting1 (car p1)) (val (cdr p1) (cdr l1)))))) 

; DEFINIZIONE "monomial-tracting1"


(defun monomial-tracting1 (m1)

  (list '* (monomial-coefficient m1)

        (cons '* (inter1 (varpowers m1))))) 

; DEFINIZIONE "inter1"


(defun inter1 (vps)

  (cond
 
   ((null vps) nil)
 
   (T (cons (adjust-vp1 (car vps)) (inter1 (cdr vps))))))



; DEFINIZIONE "adjust-vp1"


(defun adjust-vp1 (vp)

  (list ' expt (varpower-symbol vp) (varpower-power vp)))