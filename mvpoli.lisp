;;;; 806906 Briola Antonio
;;;; 807060 Bernori Nicolo'

; DEFINIZIONE "is-monomial"

; Il codice della funzione "is-monomial", parzialmente
; fornito nella traccia, è stato qui rafforzato in
; modo da contemplare tutte le possibili "forme" in cui
; un monomio possa eventualmente presentarsi.

(defun is-monomial (m)
  (and (listp m)
    (eq 'm (first m))
    (let ((mtd (monomial-degree m))
          (vps (varpowers m)))
        (or

          ; Si è qui considerato il caso in cui il monomio
          ; sia nullo e abbia quindi grado pari a -1.
          (and (integerp mtd)
               (= mtd (- 1))
               (listp vps)
               (equal vps ()))

          ; Si è qui considerato il caso in cui il monomio sia
          ; costituito da un generico intero e abbia quindi
          ; grado pari a 0.
          (and (integerp mtd)
               (= mtd 0)
               (listp vps)
               (equal vps nil))

          ; Si è qui considerato il caso in cui il monomio
          ; sia della forma "intero, variabile/i".
          (and (integerp mtd)
               (> mtd 0)
               (listp vps)
               (not (equal vps ()))
               (every #'is-varpower vps))))))

; DEFINIZIONE "monomial-degree"

; La funzione "monomial-degree" ha il compito di eseguire
; una serie di test sul monomio al fine di accertarne la
; correttezza formale e quindi restituire il suo
; grado totale.

(defun monomial-degree (m)

; Viene innanzitutto testata la "forma" in cui il monomio
; viene passato in input. Viene cioè distinto il caso
; in cui in input sia ricevuta una struttura di tipo monomio,
; dal caso in cui, invece, in input sia ricevuto un monomio
; in forma non parsata (ad esempio (* 3 x)).
(cond
  ((equal (car m) 'm)
    (cond

      ; Si è qui considerato il caso in cui il monomio ricevuto
      ; in input sia un semplice intero, il cui grado totale è
      ; quindi pari a 0.
      ((and
        (equal (first m) 'm)
        (not (= (second m) 0))
        (= (third m) 0)
        (or
          (equal (fourth m) ())
          (equal (fourth m) nil)))
      0)

      ; Si è qui considerato il caso in cui il monomio ricevuto
      ; in input sia un monomio nullo, il cui grado totale è
      ; quindi pari a -1.
      ((and
        (equal (first m) 'm)
        (= (second m) 0)
        (= (third m) (- 1))
        (equal (fourth m) ()))
      (- 1))

      ; Si è qui considerato il caso in cui il monomio ricevuto
      ; in input sia errato. In particolare si è considerato il
      ; caso in cui il grado totale specificato sia un valore
      ; maggiore oppure uguale a 0 mentre la lista delle variabili
      ; è vuota.
      ((and
        (equal (first m) 'm)
        (numberp (second m))
        (>= (third m) 0)
        (or
          (equal (fourth m) ())
          (and
            (= (list-length (fourth m)) 1)
            (equal (first (fourth m)) ()))
            (and
              (> (list-length (fourth m)) 1)
              (null (one-level (fourth m))))))

        "Error in monomial-degree")

        ; Si è qui considerato il caso in cui il monomio ricevuto
        ; in input sia un monomio della forma "coefficiente,
        ; variabile/i" e si è quindi verificata la corrispondenza
        ; fra grado totale specificato in input e somma degli
        ; esponenti delle variabili specificate nell'apposita lista.
        ; Quest'ultima operazione è stata compiuta richiamando
        ; la funzione "sum-of-degrees".
        ((and
          (equal (first m) 'm)
          (numberp (second m))
          (numberp (third m))
          (listp (fourth m))
          (every #'listp (fourth m))
          (= (third m) (sum-of-degrees (fourth m))))
        (third m))

        ; Si è qui considerato ogni altro caso escluso dalle
        ; precedenti trattazioni.
        (T "Error in monomial-degree")))

  (T (monomial-degree (as-monomial m)))))

; DEFINIZONE "e-list-sum"

; La funzione "e-list-sum" riceve in input una lista
; (ad un singolo livello) di interi e li somma fra loro.

(defun e-list-sum (l)
  (cond

    ; Nel caso in cui la lista ricevuta in input
    ; sia una lista vuota la funzione ritorna il
    ; valore 0.
    ((null l) 0)

    ; La somma degli elementi della lista viene
    ; calcolata applicando la ricorsione;
    (T (+ (car l) (e-list-sum (cdr l))))))

; DEFINZIONE "sum-of-degrees"

; La funzione "sum-of-degrees" riceve in input una lista
; completa delle variabili e dei rispettivi esponenti
; presenti in un monomio e restituisce la somma degli
; esponenti stessi.

(defun sum-of-degrees (l)
  (cond

    ; Con questa prima condizione si verifica che quanto
    ; ricevuto in input corrisponda effettivamente ad
    ; una lista.
    ((and
      (listp (fourth l))

    ; La lista delle variabili e corrispettivi esponenti
    ; ricevuta in input:
    ;   - viene ridotta ad un unico livello richiamando la
    ;     funzione "one-level";
    ;   - vengono estratti i esponenti richiamando la
    ;     funzione "extract-integers-from-list";
    ;   - si procede alla somma dei valori contenuti all'
    ;     interno della lista dopo aver richiamato ancora
    ;     una volta la funzione "one-level".
      (e-list-sum
        (one-level
          (extract-integers-from-list
            (one-level l))))))

    ; Questa condizione copre il caso in cui quanto ricevuto
    ; in input non sia una lista.
    (T "Error in sum-of-degrees")))

; DEFINIZIONE "varpowers"

; La funzione "varpowers" riceve in input un monomio e ritorna
; la lista delle variabili e rispettivi coefficienti (qualora
; presenti).

(defun varpowers (m)

; Viene innanzitutto testata la "forma" in cui il monomio
; viene passato in input. Viene cioè distinto il caso
; in cui in input sia ricevuta una struttura di tipo monomio
; (ad esempio (m 3 7 ((v 2 a) (v 3 z) (v 2 i)))),
; dal caso in cui, invece, in input sia ricevuto un monomio
; in forma non parsata (ad esempio (* 3 x)).
(cond
  ((equal (car m) 'm)

    (cond

      ; Si è qui considerato il caso in cui il monomio ricevuto
      ; in input sia della forma "coefficente, variabile/i".
      ; Nel caso in cui ogni elemento del quarto termine
      ; della struttura monomio sia una variabile con annesso
      ; esponente, la funzione ritorna il quarto termine stesso.
      ((and
        (equal (first m) 'm)
        (numberp (second m))
        (> (third m) 0)
        (listp (fourth m))
        (every #'is-varpower (fourth m)))
      (fourth m))

     ; Si è qui considerato il caso in cui il monomio ricevuto
     ; in input sia un semplice intero privo, pertanto, di
     ; di variabili (e annessi esponenti).
     ((and
       (equal (first m) 'm)
       (and
         (numberp (second m))
         (> (second m) 0))
       (= (third m) 0)
       (equal (fourth m) nil))
     ())

    ; Si è qui considerato il caso in cui il monomio ricevuto
    ; in input sia un semplice intero (negativo) privo,
    ; pertanto, di variabili (e annessi esponenti).
    ((and
      (equal (first m) 'm)
      (and
        (numberp (second m))
        (< (second m) 0))
      (= (third m) 0)
      (equal (fourth m) nil))
    ())

    ; Si è qui considerato il caso in cui il monomio ricevuto
    ; in input sia un monomio nullo (quindi della forma
    ; (m 0 -1 nil), pertanto privo di
    ; di variabili (e annessi esponenti).
    ((and
      (equal (first m) 'm)
      (and
        (numberp (second m))
        (= (second m) 0))
      (= (third m) (- 1))
      (equal (fourth m) nil))
    ())

    ; Questa condizione copre tutta la casistica esclusa dalle
    ; precedenti trattazioni.
    (T "Error in varpowers")))

  (T (varpowers (as-monomial m)))))

; DEFINIZIONE "one-level"

; La funzione "one-level" riceve in input
; una generica lista a più livelli e restituisce
; la stessa lista ridotta ad un unico livello.
; Tale funzione è comunemente conosciuta con il
; nome di "flatten".

(defun one-level (l)
  (cond

    ; Se la lista ricevuta in input è una lista vuota
    ; la funzione ritorna "nil" (ossia la lista stessa).
    ((null l) l)

    ; Se l'input è costituito da un semplice atomo, la funzione
    ; ritorna una lista di un solo elemento: l'atomo stesso.
    ((atom l) (list l))

    ; Nel caso in cui l'input sia costituito da una lista
    ; è possibile giungere al risultato sperato semplicemente
    ; applicando la ricorsione.
    (T (append
          (one-level (first l))
          (one-level (rest l))))))

; DEFINZIONE "extract-integers-from-list"

; La funzione "extract-integers-from-list" riceve in input
; una lista i cui elementi risultano essere interi e caratteri
; e restituisce una lista contenente i soli interi. Tale funzione
; esegue il proprio compito utilizzando, ancora una volta,
; la ricorsione.

(defun extract-integers-from-list (l)
  (cond

    ; Nel caso in cui la lista sia costituita da un solo
    ; elemento e questo sia un intero, la funzione ritorna
    ; una lista contenente quel valore stesso.
    ((and
      (= (list-length l) 1)
      (numberp (car l)))
      (car l))

    ; Nel caso in cui la lista sia costituita da un solo
    ; elemento e questo non sia un intero, la funzione ritorna
    ; semplicemente "nil".
    ((and
      (= (list-length l) 1)
      (not (numberp (car l))))
      nil)

    ; In tutti gli altri casi è possibile giungere al risultato
    ; semplicemente applicando la ricorsione.
    (T (cons
          (extract-integers-from-list (list (car l)))
          (extract-integers-from-list (cdr l))))))

; DEFINIZONE "is-varpower"

; La funzione "is-varpower" riceve in input una
; lista rappresentante la struttura "varaibile, esponente",
; e ne verifica la correttezza.

(defun is-varpower (vp)

  ; Viene innanzitutto controllato che l'input
  ; sia una lista.
  (and (listp vp)

    ; Il primo elemento della lista deve essere
    ; la stringa 'v.
    (equal 'v (first vp))

       ; Viene richiamata la funzione "varpower-power" al
       ; al fine di estrarre l'esponente della struttura
       ; ricevuta in input e la funzione "varpower-symbol"
       ; al fine di estrarre la variabile della struttura
       ; ricevuta in input;
       (let ((p (varpower-power vp))
             (r (varpower-symbol vp)))

            ; L'esponente può avere valore pari a zero e
            ; in questo caso la struttura assumerebbe
            ; logicamente il valore uno oppure può avere
            ; valore positivo.
            (or (and (integerp p)
                     (= p 0)
                     (symbolp r))
                (and (integerp p)
                     (> p 0)
                     (symbolp r))))))

; DEFINIZIONE "varpower-power"

; La funzione "varpower-power" riceve in input una
; lista rappresentante la struttura "varaibile, esponente",
; ed estrae l'esponente in essa contenuto.

(defun varpower-power (vp)
  (cond
    ((= (list-length vp) 0) 0)

    (T(second vp))))

; DEFINIZIONE "varpower-symbol"

; La funzione "varpower-symbol" riceve in input una
; lista rappresentante la struttura "varaibile, esponente",
; ed estrae il simbolo di variabile in essa contenuta.

(defun varpower-symbol (vp)
  (cond
    ((= (list-length vp) 0) nil); #\x

    (T (third vp))))

; DEFINIZIONE "vars-of"

; La funzione "vars-of" riceve in input un monomio
; e ritorna la lista delle variabili in esso contenute.

(defun vars-of (m)

; Viene innanzitutto testata la "forma" in cui il monomio
; viene passato in input. Viene cioè distinto il caso
; in cui in input sia ricevuta una struttura di tipo monomio,
; dal caso in cui, invece, in input sia ricevuto un monomio
; in forma non parsata (ad esempio (* 3 x)).
(cond
  ((equal (car m) 'm)

      (cond

        ; La funzione verifica innanzitutto che quanto
        ; ricevuto in input sia un monomio. Invoca quindi la
        ; funzione "work-on-list" passando come argomento
        ; "varpowers" e restituisce la lista (priva di duplicati)
        ; delle variabili esattamente nell'ordine in cui appaiono
        ; nel monomio.
        ((is-monomial m)

          (if (not (equal (work-on-list (varpowers m)) nil))
                  (remove-duplicates
                    (work-on-list (varpowers m)))
            nil))

        ; Questa condizione copre il caso in cui l'input
        ; non sia un monomio.
        (T "Error in vars-of")))

  (T (vars-of (as-monomial m)))))

; DEFINIZIONE "work-on-list"

; La funzione "work-on-list" riceve in input una lista
; contenente liste (ossia tutte le triple
; "v, esponente, variabile") ed estrae da ciascuna la
; variabile.

(defun work-on-list (l)
  (cond

    ; Nel caso in cui il monomio sia dotato di una sola
    ; varibile (e quindi di una lista "varpowers" di lunghezza
    ; pari ad uno) la funzione ritorna quell'unica variabile.
    ((= (list-length l) 1) (cons (third (car l)) nil))

    ; Qualora il monomio ricevuto in input sia nullo
    ; la funzione restituisce un messaggio in cui
    ; specifica che nel monomio ricevuto non vi sono
    ; variabili.
    ((equal l ()) nil)

    ; In tutti gli altri casi la funzione
    ; restituisce la lista delle variabili contenute
    ; nel monomio ricevuto in input semplicemente
    ; applicando la ricorsione.
    (T (cons (third (car l)) (work-on-list (cdr l))))))

; DEFINIZIONE "monomial-coefficient"

; La funzione "monomial-coefficient" riceve in input un
; monomio, ne verifica l'effettiva natura
; ed eventualmente restituisce il coefficiente
; del monommio stesso.

(defun monomial-coefficient (m)

; Viene innanzitutto testata la "forma" in cui il monomio
; viene passato in input. Viene cioè distinto il caso
; in cui in input sia ricevuta una struttura di tipo monomio,
; dal caso in cui, invece, in input sia ricevuto un monomio
; in forma non parsata (ad esempio (* 3 x)).
(cond
  ((equal (car m) 'm)

    (cond
      ((is-monomial m) (second m))

      ; Questa condizione copre il caso particolare in cui
      ; quanto ricevuto in input non sia effettivamente un
      ; monomio.
      (T "Error in monomial-coefficient")))

  (T (monomial-coefficient (as-monomial m)))))

; DEFINIZIONE "is-polynomial"

; La funzione "is-polynomial" riceve in input una
; struttura di tipo polinomio e verifica la
; correttezza di tale struttura.

(defun is-polynomial (p)

  ; La struttura polinomio deve innanzitutto essere
  ; una lista. Il primo elemento deve essere la
  ; stringa 'p oppure 'poly (si è voluto contemplare
  ; entrambe le possibilità a causa delle discrepanze
  ; fra quanto presente sulla consegna concernente
  ; la libreria in Common-Lisp, quanto presente
  ; sulla consegna concernente la libreria Prolog e,
  ; da ultimo, quanto riportato sul "forum".
  (and (listp p)
         (or
           (eq 'poly (first p))
           (eq 'p (first p)))

       (let ((ms (poly-monomials p)))

            (and
              (listp ms)

              ; La funzione "every" verifica che ogni
              ; elemento della lista che segue
              ; la stringa 'poly (o 'p) sia effettivamente una
              ; struttura di tipo polinomio.
              (every #'is-monomial ms)))))

; DEFINIZIONE "poly-monomials"

; La funzione "poly-monomials" riceve in input un polinomio
; e restituisce la lista di tutti i monomi che
; lo costituiscono.

(defun poly-monomials (p)
  (second p))

; DEFINIZIONE "coefficients"

; La funzione "coefficients" riceve in input un polinomio,
; verifica la correttezza della sua struttura e, in caso
; affermativo, ritorna una lista dei coefficienti del
; polinomio stesso nell'ordine esatto in cui si presentano.

(defun coefficients (p)

  ; Viene innanzitutto testata la "forma" in cui il monomio
  ; viene passato in input. Viene cioè distinto il caso
  ; in cui in input sia ricevuta una struttura di tipo monomio,
  ; dal caso in cui, invece, in input sia ricevuto un monomio
  ; in forma non parsata (ad esempio (* 3 x)).
  (cond
    ((or
      (equal (car p) 'p)
      (equal (car p) 'poly))

     (cond

        ; La funzione controlla innanzitutto che quanto
        ; ricevuto in input sia un polinomio, in caso
        ; negativo ritorna un messaggio di errore.
        ((not (is-polynomial p)) "Error in is-polynomial")

        (T (remove-duplicates (one-level

              ; Viene qui richiamata la funzione
              ; "work-on-coefficient-list" passandole come argomento
              ; una lista contenente tutti i monomi di cui
              ; è costituito il polinomio.
              (work-on-coefficient-list
                  (poly-monomials p))) :test #'= :from-end t))))

   (T (coefficients (as-polynomial p)))))

; DEFINIZIONE "work-on-coefficient-list"

; La funzione "work-on-coefficient-list" riceve in input
; una lista di monomi e restituisce una lista contenente
; il coefficiente di ciascun monomio.

(defun work-on-coefficient-list (l)
  (cond

    ; Viene innanzitutto testato che quanto ricevuto in input
    ; sia una lista.
    ((not (listp l)) "Error in work-on-coefficient-list")

    ; Nel caso in cui la lsta ricevuta in input sia
    ; vuota la funzione ritorna "nil".
    ((= (list-length l) 0) nil)

    ; Nel caso in cui l'input sia costituito da una lista di
    ; lunghezza pari ad uno, la funzione ritorna semplicemente
    ; il coefficiente dell'unico monomio presente.
    ((= (list-length l) 1) (monomial-coefficient (car l)))

    ; Nel caso in cui l'input sia costituito da una lista di
    ; lunghezza superiore ad uno, la funzione estrae il
    ; coefficiente di ciascun monomio applicando la ricorsione
    ; e ritorna quindi una lista contenente tutti i coefficienti
    ; esattamente nell'ordine in cui si presentano.
    (T (cons (monomial-coefficient (car l))
             (work-on-coefficient-list (cdr l))))))

; DEFINIZIONE "variables"

; La funzione "varaibles" riceve in input un polinomio,
; verifica la correttezza della sua struttura e, in caso
; affermativo, ritorna una lista delle variabili del
; polinomio stesso.

(defun variables (p)

  ; Viene innanzitutto testata la "forma" in cui il monomio
  ; viene passato in input. Viene cioè distinto il caso
  ; in cui in input sia ricevuta una struttura di tipo monomio,
  ; dal caso in cui, invece, in input sia ricevuto un monomio
  ; in forma non parsata (ad esempio (* 3 x)).
  (cond
    ((or
      (equal (car p) 'p)
      (equal (car p) 'poly))

      (cond

        ; La funzione controlla innanzitutto che quanto
        ; ricevuto in input sia un polinomio, in caso
        ; negativo ritorna un messaggio di errore.
        ((not (is-polynomial p)) "Error in is-polynomial")

        (T (remove-if #'stringp
              (one-level

                  ; Viene qui richiamata la funzione
                  ; "work-on-variables-list" passandole come argomento
                  ; una lista contenente tutti i monomi di cui
                  ; è costituito il polinomio.
                  (work-on-variables-list
                      (poly-monomials p)))))))

  (T (variables (as-polynomial p)))))

; DEFINIZIONE "work-on-variables-list"

; La funzione "work-on-coefficient-list" riceve in input
; una lista di monomi e restituisce una lista contenente
; le variabili di ciascun monomio.

(defun work-on-variables-list (l)
  (cond
    ((not (listp l)) "Error in work-on-variables-list")

    ((= (list-length l) 0) nil)

    ; Nel caso in cui l'input sia costituito da una lista di
    ; lunghezza pari ad uno, la funzione ritorna semplicemente
    ; le variabili dell'unico monomio presente.
    ((= (list-length l) 1) (vars-of (car l)))

    ; Nel caso in cui l'input sia costituito da una lista di
    ; lunghezza superiore ad uno, la funzione estrae le
    ; varaibili di ciascun monomio applicando la ricorsione.
    (T (cons (vars-of (car l))
             (work-on-variables-list(cdr l))))))

; DEFINIZIONE "max-degree"

; La funzione "max-degree" riceve in input un polinomio
; e restituisce il più alto fra i gradi totali dei monomi
; che costituiscono il polinomio stesso.

(defun maxdegree (p)

  ; Viene innanzitutto testata la "forma" in cui il monomio
  ; viene passato in input. Viene cioè distinto il caso
  ; in cui in input sia ricevuta una struttura di tipo monomio,
  ; dal caso in cui, invece, in input sia ricevuto un monomio
  ; in forma non parsata (ad esempio (* 3 x)).
  (cond
    ((or
      (equal (car p) 'p)
      (equal (car p) 'poly))

    (cond

        ; La funzione controlla innanzitutto che l'input sia
        ; costitutito da un polinomio e in caso negativo
        ; restituisce un messaggio di errore.
        ((not (is-polynomial p)) "Error in is-polynomial")

        ; Viene richiamata la funzione "max-in-a-list" al fine
        ; di rintracciare il massimo valore nella lista
        ; contenente i gradi complessivi di ciascun monomio
        ; presente all'interno del polinomio.
        (T (max-in-a-list (degrees p)))))

 (T (maxdegree (as-polynomial p)))))

; DEFINIZIONE "max-in-a-list"

; La funzione "max-in-a-list" riceve in input una lista di
; interi (nel nostro caso i gradi complessivi di tutti i monomi
; presenti all'interno di un polinomio) e ricava il massimo
; valore applicando la ricorsione.

(defun max-in-a-list (l)
  (cond
    ((= (list-length l) 1) (car l))

    (T (if (> (car l) (max-in-a-list (cdr l)))
           (car l) (max-in-a-list (cdr l))))))

; DEFINIZIONE "degrees"

; La funzione "degrees" riceve in input un polinomio
; ed estrae i gradi totali di ciascun monomio presente
; al suo interno.

(defun degrees (d)
  (cond

    ; La funzione controlla innanzitutto che l'input
    ; sia costituito da una struttura di tipo
    ; polinomio. In caso negativo
    ; ritorna un messaggio di errore.
    ((not (is-polynomial d)) "Error in is-polynomial")

    (T (one-level

          ; Viene qui richiamata la funzione
          ; "work-on-degrees-list" passandole come argomento
          ; una lista contenente tutti i monomi di cui
          ; è costituito il polinomio.
          (work-on-degrees-list
              (poly-monomials d))))))

; DEFINIZIONE "work-on-degrees-list"

; La funzione "work-on-degrees-list" riceve in input
; una lista di monomi e restituisce una lista contenente
; il grado totale di ciascun monomio.

(defun work-on-degrees-list (l)
  (cond
    ((not (listp l)) "Error")

    ((= (list-length l) 0) nil)

    ; Nel caso in cui l'input sia costituito da una lista di
    ; lunghezza pari ad uno, la funzione ritorna semplicemente
    ; il grado totale dell'unico monomio presente.
    ((= (list-length l) 1) (monomial-degree (car l)))

    ; Nel caso in cui l'input sia costituito da una lista di
    ; lunghezza superiore ad uno, la funzione estrae il
    ; grado totale di ciascun monomio applicando la ricorsione.
    (T (cons (monomial-degree (car l))
             (work-on-degrees-list (cdr l))))))

; DEFINIZIONE "mindegree"

; La funzione "min-degree" riceve in input un polinomio
; e restituisce il più basso fra i gradi totali dei monomi
; che costituiscono il polinomio stesso.

(defun mindegree (p)

  ; Viene innanzitutto testata la "forma" in cui il monomio
  ; viene passato in input. Viene cioè distinto il caso
  ; in cui in input sia ricevuta una struttura di tipo monomio,
  ; dal caso in cui, invece, in input sia ricevuto un monomio
  ; in forma non parsata (ad esempio (* 3 x)).
  (cond
    ((or
      (equal (car p) 'p)
      (equal (car p) 'poly))
     (cond

      ; La funzione controlla innanzitutto che l'input sia
      ; costitutito da un polinomio e in caso negativo
      ; restituisce un messaggio di errore.
      ((not (is-polynomial p)) "Error in is-polynomial")

      ; Viene richiamata la funzione "min-in-a-list" al fine
      ; di rintracciare il minimo valore nella lista
      ; contenente i gradi complessivi di ciascun monomio
      ; presente all'interno del polinomio.
      (T (min-in-a-list (degrees p)))))

  (T (mindegree (as-polynomial p)))))

; DEFINIZIONE "min-in-a-list"

; La funzione "min-in-a-list" riceve in input una lista di
; interi (nel nostro caso i gradi complessivi di tutti i monomi
; presenti all'interno di un polinomio) e ricava il minimo
; valore applicando la ricorsione.

(defun min-in-a-list (l)
 (cond
   ((= (list-length l) 1) (car l))

   (T (if (< (car l) (min-in-a-list (cdr l)))
          (car l) (min-in-a-list (cdr l))))))

; DEFINIZIONE "as-monomial"

; La funzione "as-monomial" ritorna la struttura dati che
; rappresnta il monomio risultante dal "parsing" della
; struttura ricevuta in input. Il monomio risultante
; sarà chiaramente ordinato secondo le specifiche
; contenute nella traccia fornita.

(defun as-monomial (expression)
  (cond

    ; Se l'espressione ricevuta in input è nulla, la
    ; funzione restituisce in output un messaggio di errore.
    ; Questa considerazione è fondamentale giacchè si è
    ; fin qui seguita la "convenzione" secondo cui il
    ; monomio nullo è unicamente 0.
    ((null expression) "This is not a monomial")

    ; Se l'espressione ricevuta in input corrisponde al
    ; monomio nullo, viene restituira una struttura
    ; del tipo: (m 0 -1 nil).
    ; ATTENZIONE: chiaramente il monomio nullo avrà
    ; grado pari a -1.
    ((equal expression '0) (list 'm expression (- 1) nil))

    ; Se l'espressione ricevuta in input risulta essere
    ; di questa forma: (* 0 x 3 u), chiaramente il monomio
    ; risultante sarà un monomio nullo (avente una struttura
    ; come quella descritta immediatamente sopra).
    ((and
      (listp expression)
      (equal (car expression) '*)
      (not (equal (list-length (cdr expression))
                  (list-length (remove '0 (cdr expression))))))
        (list 'm 0 (- 1) nil))

    ; Questo caso valuta la situzione in cui l'input
    ; fosse costituito semplicemente da un intero.
    ((numberp expression)
        (monomial-ordering
            (list 'm expression '0 nil)))

    ; Per completezza (e soprattutto a scanso di equivoci)
    ; si è qui voluto trattare il caso
    ; in cui l'input fosse sì costituito da
    ; un semplice intero passato sotto forma di
    ; unico elemento di una lista.
    ((and
      (listp expression)
      (equal (list-length expression) 1)
      (numberp (car expression)))
      (list 'm (car expression) '0 nil))

    ; Questo caso valuta la situzione in cui l'input
    ; fosse semplicemente un valore letterale (avente,
    ; quindi, come coefficiente il valore 1).
    ((atom expression)
        (monomial-ordering
          (list 'm '1 '1 (list (list 'v '1 expression)))))

    ; Questo caso valuta la situzione in cui l'input
    ; fosse costituito da una singola variabile elevata ad un
    ; valore pari a zero.
    ((and
      (listp expression)
      (equal (first expression) 'expt)
      (atom (second expression))
      (equal (third expression) 0))
    (list 'm '1 0 nil))

    ; Questo caso valuta la situzione in cui l'input
    ; fosse costituito da una singola variabile elevata ad un
    ; certo esponente.
    ((and
      (listp expression)
      (equal (first expression) 'expt)
      (atom (second expression))
      (and
        (numberp (third expression))
        (> (third expression) 0)))
     (monomial-ordering
       (list 'm '1 (third expression)
          (list (list 'v (third expression)
            (second expression))))))

      ; Questo caso valuta la situazione in cui l'input
      ; fosse della forma (+ (* x) (* x) (* x)...).
      ((and
        (listp expression)
        (equal (first expression) '+))
       (second (second (polyplus (as-polynomial expression) '(m 0 -1 ())))))


      ; Viene qui valutata la situazione in cui l'input
      ; fosse della forma (*). Rispettando le regole
      ; valide nei campi algebrici, questo input
      ; produce output (m 1 0 nil).
      ((and
        (listp expression)
        (equal (list-length expression) 1)
        (equal (first expression) '*))
        (list 'm 1 0 nil))

    ; Questo caso prende in considerazione tutto ciò che
    ; è stato escluso dalle precedentitrattazioni.
    (T (monomial-ordering
          (reductio_ad_unum
              (mapcar #'as-monomial (cdr expression)))))))

; DEFINIZIONE "mul-el"

; La funzione "mul-el" riceve in input una lista di interi
; e li moltiplica fra loro.

(defun mul-el (l)
  (cond
    ((null l) nil)

    ((= (list-length l) 1) (car l))

    (T (* (car l) (mul-el (cdr l))))))

; DEFINIZIONE "sum-el"

; La funzione "sum-el" riceve in input una lista di interi
; e li somma fra loro.

(defun sum-el (l)
  (cond
    ((null l) nil)

    ((= (list-length l) 1) (car l))

    (T (+ (car l) (sum-el (cdr l))))))

; DEFINIZIONE "second-level-list"

; La funzione "second-level-list" riceve in input una lista
; di un unico elemento e restituisce il primo elemento della
; stessa.

(defun second-level-list (l)
  (cond
    ((= (list-length l) 1) (car l))))

; DEFINIZIONE "reductio_ad_unum"

; La funzione "reductio_ad_unum" ha l'arduo compito di
; assemblare la struttura parsata di un monomio. Essa
; riceve in input una lista e compie una serie
; di operazioni (sotto minuziosamente descritte) sulla stessa.

(defun  reductio_ad_unum (l)

  ; Viene innanzitutto definito quello che sarà il
  ; coefficiente del monomio: viene definita una
  ; lista contenente i coefficienti di ciascun componente
  ; del monomio. Essa viene poi passata alla funzione
  ; "mul-el".
  (let ((coeff (mul-el
              (mapcar #'monomial-coefficient l)))

        ; Viene poi definito quello che sarà il grado
        ; totale del monomio: viene definita una lista
        ; contenete i gradi di ciascun componenete
        ; del monomio. Essa viene poi passata alla funzione
        ; "sum-el".
        (td (sum-el
              (mapcar #'monomial-degree l)))

        ; Viene infine definita quella che sarà la lista
        ; di tutte le variabili con annessi esponenti del
        ; monomio. Ciò è reso possibile dall'applicazione
        ; sequenziale e atomica della funzione "second-level-list"
        ; su ciascuna "varpower" della lista ricevuta in input.
        ; Interessante è capire il funzionamento della funzione
        ; "sum-for-var". Essa riceve in input la lista
        ; di tutte le variabili con annessi esponenti e
        ; confrontandoli a coppie di due stabilisce la presenza
        ; di eventuali uguaglianze ridotte immediatamente ad
        ; un "unicum" compatto.
        (varp (sum-for-var (remove nil
          (mapcar #'second-level-list (mapcar #'varpowers l)) :test #'equal))))


        ; Si ha quindi l'assemblaggio finale dei valori ottenuti
        ; mediante l'applicazione delle operazioni sopra
        ; descritte.
        (list 'm coeff td (remove nil varp))))

; DEFINIZIONE "sum-for-var"

; La funzione "sum-for-var" riceve in input una lista di
; variabili e annessi esponenti, li confronta a coppie di
; due, stabilisce eventuali uguaglianze ed eventualmente
; riduce queste ultime ad un "unicum" compatto.

(defun sum-for-var (l)
  (cond
    ((null l) l)

    ((equal (third (car l)) (third (car (cdr l))))
    (sum-for-var (cons
            (list (first (car l)) (+ (second (car l))
                         (second (car (cdr l))))
                      (third (car l)))

            (sum-for-var (cdr (cdr l))))))

  (T (cons (car l) (sum-for-var (cdr l))))))

; DEFINIZIONE "monomial-ordering"

; La funzione "monomial-ordering" riceve in input un monomio
; ed effettua un ordinamento della "sezione varpowers"
; richiamando la funzione "monomial-order".

(defun monomial-ordering (m)
  (list 'm (second m) (third m) (monomial-order (varpowers m))))

; DEFINIZIONE "monomial-order"

; La funzione "monomial-order" riceve in input una
; lista "varpowers", scorre ciascun elemento (lista
; anch'esso) e ordina in base al terzo termine, ossia
; in base all'ordine lessicografico delle variabili
; presenti.

(defun monomial-order (l)
  (sort l #'string-lessp :key #'third))

; DEFINIZIONE "as-polynomial"

; La funzione "as-polynomial" riceve in input una lista
; rappresentante un polinomio passato in forma non
; non parsata e applica su ciascuno dei suoi componenti
; la funzione "as-monomial" e quindi ordinando il polinomio
; ottenuto.

(defun as-polynomial (l)
  (cond

    ; Si è qui considerato il caso in cui fosse ricevuto in
    ; input un valore intero maggiore strettamente
    ; oppure minore strettamente di 0.
    ((and
      (numberp l)
      (not (equal l 0))
      ) (list 'poly (cons (as-monomial l) nil)))

    ; Si è qui considerato il caso in cui fosse ricevuto
    ; in input un valore uguale a 0. In questa evenienza
    ; sarebbe ritornata una struttura del tipo: (poly nil).
    ; ATTENZIONE: potrebbe sembrare questa una discrepanza
    ; con quanto asserito sopra, ossia che il monomio nullo
    ; risulta chiaramente avere una struttura del tipo
    ; (m 0 -1 nil). Si è fatta dunque questa scelta ancora una
    ; volta per mancanza di specifiche direttive in merito
    ; e discrepanze fra quanto presente sui vari strumenti
    ; atti al supporto in fase di creazione di questa libreria,
    ; assumendo tuttavia che il "nil" seguente la stringa,
    ; SI NOTI BENE, 'poly (si è dunque qui deciso di adottare
    ; lo "standard" 'poly, piuttosto che quello 'p, in quanto,
    ; secondo quanto riportato nel "forum", in caso di discrepanze
    ; fra le due consegne sarebbe sempre meglio osservare quanto
    ; specificato riguardo la creazione della libreria Prolog),
    ; rappresenti, appunto, una struttura del tipo (m 0 -1 nil).
    ((and
      (numberp l)
      (equal l 0))

     (list 'poly nil))

      ; Mediante l'utilizzo della funzione "polyplus" applicata
      ; sulla lista monomi appositamente preparata per il
      ; passaggio, è possibile prevenire input eccessivamente
      ; "opulenti".
      (T (list 'poly (cdr (second (polyplus (list 'poly (poly-ordering
        (mapcar #'as-monomial (cdr l)))) '(m 0 -1 nil))))))))

; DEFINIZIONE "poly-m-ordering"

; La funzione "poly-ordering" riceve in input un polinomio
; e ordina ciascun monomio al suo interno in base alle
; regole preedentemente viste nel commento alla funzione
; "monomial-ordering".

(defun poly-m-ordering (p)
  (mapcar #'monomial-ordering p))

 ;DEFINIZIONE "poly-s-ordering"

; La funzione "poly-ordering" riceve in input un polinomio,
; richiama la funzione "poly-m-ordering" passandogli in input
; il polinomio stesso e solo a questo punto si ha l'ordinamento
; finale del polinomio grazie all'utilizzo della funzione "sort
; rimaneggiata" mediante "discriminate".

(defun poly-ordering (p)
  (sort (poly-m-ordering p) #'discriminate))

; DEFINIZIONE "discriminate"

; La funzione "discriminate" riceve in input due monomi
; e li confronta prima in base al grado totale e poi, in
; caso di parità dello stesso, in base e alle variabili
; e alla struttura della "sezione varpowers". In
; particolare, come riportato nella traccia fornita per
; il seguente processo, dati ad esempio due monomi del tipo:
;   - m1: ab
;   - m2: a^2
; diremo innanzitutto che essi sono dotati di medesimo grado
; totale (2) e, in seconda istanza, che nell'ordinamento,
; m1 precederà m1 poichè a < a^2. E' estremamente interessante
; notare come questa funzione altro non sia che una versione
; della funzione "sort", potremmo dire, "rimaneggiata". In
; quanto tale essa continuerà a restituire valori di tipo
; booleano.

(defun discriminate (m1 m2)
  (cond
    ((null m1) T)
    ((null m2) NIL)

    ((< (third m1) (third m2)) T)
    ((> (third m1) (third m2)) NIL)

    ((and
      (equal (third m1) (third m2))
      (string-lessp (third (first (fourth m1))) (third (first (fourth m2))))
      (> (list-length (fourth m1)) (list-length (fourth m2))))
      T)

      ((and
        (equal (third m1) (third m2))
        (string-lessp
          (third (first (fourth m1)))
          (third (first (fourth m2))))
        (= (list-length (fourth m1)) (list-length (fourth m2))))
        T)

    ((and
      (equal (third m1) (third m2))
      (not (string-lessp
            (third (first (fourth m1)))
            (third (first (fourth m2)))))
      (> (list-length (fourth m1)) (list-length (fourth m2))))
      T)))

; DEFINIZIONE "monomials"

; La funzione "monomials" riceve in input un polinomio
; ed estrae una lista ordinata dei monomi che lo
; costituiscono.

(defun monomials (p)

  ; Viene innanzitutto testata la "forma" in cui il monomio
  ; viene passato in input. Viene cioè distinto il caso
  ; in cui in input sia ricevuta una struttura di tipo monomio,
  ; dal caso in cui, invece, in input sia ricevuto un monomio
  ; in forma non parsata (ad esempio (* 3 x)).
  (cond
    ((or
      (equal (car p) 'p)
      (equal (car p) 'poly))

     (cond
      ((not (is-polynomial p)) "Error in is-polynomial")

      (T (poly-ordering (second p)))))
  (T (monomials (as-polynomial p)))))

; DEFINIZIONE "polyplus"

; La funzione "polyplus" riceve in input due polinomi e
; li somma fra loro.

(defun polyplus (p1 p2)
  (cond

    ; Si è qui gestito il caso in cui in input siano ricevuti
    ; due interi.
    ((and
      (numberp p1)
      (numberp p2))
      (list 'poly
            (remove '(m 0 -1 nil)
              (second (polyplus (as-monomial p1) (as-monomial p2)))
            :test #'equal)))

    ; Si è qui gestito lo sfortunato caso in cui in input
    ; sia ricevuto un intero e una struttura di tipo polinomio,
    ; si noti bene, nullo.
    ((and
      (numberp p1)
      (is-polynomial p2)
      (equal '(poly nil) p2))
      (as-polynomial p1))

    ; Si è qui gestito il caso in cui in input sia
    ; ricevuta una struttura di tipo polinomio, si noti bene,
    ; nullo e un intero.
    ((and
      (numberp p2)
      (is-polynomial p1)
      (equal '(poly nil) p1))
      (as-polynomial p2))

    ; Si è qui gestito il caso in cui in input sia ricevuto un
    ; intero e una generica struttura di tipo polinomio non
    ; nullo.
    ((and
      (numberp p1)
      (is-polynomial p2))
      (list 'poly (remove '(m 0 -1 nil)
                    (second (polyplus (as-monomial p1) p2))
                  :test #'equal)))

    ; Si è qui gestito il caso in cui in input sia ricevuta una
    ; generica struttura di tipo polinomio non nullo e un intero.
    ((and
      (is-polynomial p1)
      (numberp p2))
      (list 'poly (remove '(m 0 -1 nil)
                    (second (polyplus p1 (as-monomial p2)))
                  :test #'equal)))

    ; Si è qui gestito il caso in cui in input sia ricevuto un
    ; intero e una struttura di tipo lista (convertibile in un
    ; polinomio, pena un errore).
    ((and
      (numberp p1)
      (listp p2))
      (list 'poly
            (remove '(m 0 -1 nil)
              (second (polyplus (as-monomial p1) (as-polynomial p2)))
            :test #'equal)))

    ; Si è qui gestito il caso in cui in input sia ricevuta una
    ; struttura di tipo lista (convertibile in un polinomio,
    ; pena un errore) e un intero.
    ((and
      (listp p1)
      (numberp p2))
      (list 'poly
            (remove '(m 0 -1 nil)
              (second (polyplus (as-polynomial p1) (as-monomial p2)))
            :test #'equal)))

    ; Sono qui gestiti i casi in cui in input siano ricevute:
    ;   - due strutture di tipo monomio;
    ;   - due strutture di tipo polinomio;
    ;   - una struttura di tipo monomio e una
    ;     struttura di tipo polinomio;
    ;   - una struttura di tipo polinomio e una
    ;     una struttura di tipo monomio;
    ;   - due strutture di tipo monomio.
    ((and
      (or
      (equal (car p1) 'p)
      (equal (car p1) 'poly)
      (equal (car p1) 'm))
      (or
        (equal (car p2) 'p)
        (equal (car p2) 'poly)
        (equal (car p2) 'm)))
    (cond

      ; Nel caso in cui in input ricevessi come
      ; argomenti due monomi innanzitutto eseguirei
      ; una "append" fra il primo argomento inserito,
      ; si faccia attenzione, nel contesto di una lista
      ; e il secondo argomento, anch'esso inserito
      ; nel contesto di un lista,
      ; richiamerei la funzione di ordinamento "poly-ordering"
      ; per l'inedita struttura in modo da avere monomi
      ; simili vicini e quindi richiamerei la funzione "sum"
      ; passando coppie di monomi. Infine "ricostruirei" il
      ; polinomio nella forma (p ((...))).
      ((and
        (is-monomial p1)
        (is-monomial p2))
          (cons 'poly
                (cons
                  (sum (poly-ordering
                          (append
                            (list p2)
                            (list p1)))) nil)))

      ; Nel caso in cui in input ricevessi come primo
      ; argomento un monomio innanzitutto eseguirei
      ; una "append" fra il primo argomento inserito,
      ; si faccia attenzione, nel contesto di una lista
      ; e il secondo argomento (necessariamente un polinomio),
      ; richiamerei la funzione di ordinamento "poly-ordering"
      ; per l'inedita struttura in modo da avere monomi
      ; simili vicini e quindi richiamerei la funzione "sum"
      ; passando coppie di monomi. Infine "ricostruirei" il
      ; polinomio nella forma (p ((...))).
      ((is-monomial p1)
          (cons 'poly
            (cons
              (sum
                (poly-ordering
                  (append (monomials p2) (list p1)))) nil)))

      ; Nel caso in cui in input ricevessi come secondo
      ; argomento un monomio innanzitutto eseguirei
      ; una "append" fra il primo argomento inserito,
      ; e il secondo argomento, si faccia attenzione,
      ; inserito nel contesto di una lista,
      ; richiamerei la funzione di ordinamento "poly-ordering"
      ; per l'inedita struttura in modo da avere monomi
      ; simili vicini e quindi richiamerei la funzione "sum"
      ; passando coppie di monomi. Infine "ricostruirei" il
      ; polinomio nella forma (p ((...))).
      ((is-monomial p2)
          (cons 'poly
                (cons
                  (sum
                    (poly-ordering
                      (append (list p2)
                              (monomials p1)))) nil)))

      ; Nel caso in cui in input ricevessi due polinomi,
      ; farei innanzitutto una append fra il risultato
      ; dell'applicazione della funzione "monomials"
      ; su entrambi i polinomi,
      ; richiamerei la funzione di ordinamento "poly-ordering"
      ; per l'inedita struttura in modo da avere monomi
      ; simili vicini e quindi richiamerei la funzione "sum"
      ; passando coppie di monomi. Infine "ricostruirei" il
      ; polinomio nella forma (p ((...))).
      ((and
        (is-polynomial p1)
        (is-polynomial p2))
        (cons 'poly
          (cons
            (sum
              (poly-ordering
                (append (monomials p2) (monomials p1)))) nil)))

        ; In ogni altro caso, che eventualmente esuli le precedenti
        ; trattazioni, produrrei un messaggio di errore.
        (T "Error in poly-plus... Let's check the input")))

   ; Vengono qui gestiti tutti i casi esclusi dalle precedenti
   ; trattazioni.
   (T (cons 'poly
            (cons
              (remove '(m 0 -1 nil) (second (polyplus (as-polynomial p1)
              (as-polynomial p2))) :test #'equal) nil)))))

; DEFINIZIONE "sum"

; La funzione "sum" effettua la somma fra monomi
; adiacenti simili ricevuti in input in una lista contenete
; tutti i monomi che formano i polinomi fra i quali si intende
; effettuare la somma.

(defun sum (l1)
  (cond
    ((null l1) nil)

    ; Viene qui gestito il caso in cui due monomi
    ; adiacenti si annullino.
    ((and

      (equal (second (car l1)) 1)

      (equal (second (car (cdr l1))) (- 1))

      (equal
        (third (car l1))
        (third (car (cdr l1))))

      (equal
        (fourth (car l1))
        (fourth (car (cdr l1)))))

       ; Per una questione di chiarezza (e soprattutto
       ; di maggiore correttezza) piuttosto che restituire
       ; un semplice "nil" si è preferito evidenziare
       ; la struttura del monomio nullo risultante (anche se,
       ; in seguito, nei casi in cui tale situazione è stata
       ; effettivamente gestita esso sarà eliminato).
       (sum (cons
              (list 'm
                    (+ (second (car l1))
                       (second (car (cdr l1))))
                    (- 1)
                    'nil)

            (sum (cdr (cdr l1))))))

    ; Viene qui gestito, ancora una volta (a parti
    ; invertite), il caso in cui due monomi adiacenti
    ; si annullino.
    ((and
       (equal (second (car l1)) (- 1))

       (equal (second (car (cdr l1))) 1)

       (equal
          (third (car l1))
          (third (car (cdr l1))))

       (equal
          (fourth (car l1))
          (fourth (car (cdr l1)))))

    ; Per una questione di chiarezza (e soprattutto
    ; di maggiore correttezza) piuttosto che restituire
    ; un semplice "nil" si è preferito evidenziare
    ; la struttura del monomio nullo risultante (anche se,
    ; in seguito, nei casi in cui tale situazione è stata
    ; effettivamente gestita esso sarà eliminato).
    (sum (cons
            (list ' m
                  (+ (second (car l1))
                     (second (car (cdr l1))))
                  (- 1)
                  'nil)

          (sum (cdr (cdr l1))))))

    ; Questa condizione verifica la condizione di similitudine
    ; fra i termini adiacenti (monomi) all'interno della lista
    ; ricevuta in input.
    ((and (equal
            (third (car l1))
            (third (car (cdr l1))))

          (equal
            (fourth (car l1))
            (fourth (car (cdr l1)))))

      ; Qualora la precedente condizione fosse soddisfatta
      ; effettuerei l'effettiva somma procedendo come segue:
      ; - si sommano i coefficienti dei due monomi simili;
      ; - si estrae il grado massimo dei monomi
      ;   (chiaramente identico in entrambi);
      ; - si estrae la lista di varpowers (anch'essa
      ;   identica in entrambi i termini.
      ; A questo punto tutto quanto precedentemente definito,
      ; viene inserito all'interno del contesto di una lista.
      (sum (cons
              (list ' m (+ (second (car l1))
                           (second (car (cdr l1))))
                        (third (car l1))
                        (sum-for-var (fourth (car l1))))

              (sum (cdr (cdr l1))))))

    ; Qualora due monomi adiacenti non fossero simili
    ; si procederebbe con il confronto fra il secondo
    ; precedentemente considerato e il successivo.
    (T (cons (car l1) (sum (cdr l1))))))

; DEFINIZIONE "polyminus"

; La funzione "polyminus" si comporta esattamente come la
; funzione "polysum": per questo motivo verrà qui tralasciata
; la descrizione minuziosa di ogni passaggio del procedimento,
; rimandando il lettore alla consultazione dei commenti sopra
; definiti. Come unico aspetto rilevante è interessante notare
; che affinchè questa operazione funzioni è necessario "rendere"
; uno dei due termini ricevuti in input negativo. A tal fine
; è stata appositamente definita la funzione "mul-coefficients".

(defun polyminus (p1 p2)
(cond

  ((and
    (numberp p1)
    (numberp p2))
    (list 'poly
          (remove '(m 0 -1 nil)
            (second (polyminus (as-polynomial p1) (as-polynomial p2)))
          :test #'equal)))

  ((and
    (numberp p1)
    (is-polynomial p2))
    (list 'poly
          (remove '(m 0 -1 nil)
            (second (polyminus (as-polynomial p1) p2))
          :test #'equal)))

  ((and
    (is-polynomial p1)
    (numberp p2))
    (list 'poly
          (remove '(m 0 -1 nil)
            (second (polyminus p1 (as-polynomial p2)))
          :test #'equal)))

  ((and
    (numberp p1)
    (listp p2))
    (list 'poly
          (remove '(m 0 -1 nil)
            (second (polyminus (as-polynomial p1) (as-polynomial p2)))
          :test #'equal)))

  ((and
    (listp p1)
    (numberp p2))
    (list 'poly
          (remove '(m 0 -1 nil)
            (second (polyminus (as-polynomial p1) (as-polynomial p2)))
          :test #'equal)))

  ((and
    (or
    (equal (car p1) 'p)
    (equal (car p1) 'poly)
    (equal (car p1) 'm))
    (or
      (equal (car p2) 'p)
      (equal (car p2) 'poly)
      (equal (car p2) 'm)))

  (cond
    ((and
      (is-monomial p1)
      (is-monomial p2))
        (cons 'poly
              (cons
                (remove
                  '(m 0 -1 nil)
                  (second
                    (cons 'poly
                      (cons
                        (sum
                          (poly-ordering
                            (append
                              (mul-coefficients (list p2) (- 1))
                              (list p1)))) nil))) :test #'equal) nil)))

    ((is-monomial p1)
        (cons 'poly
              (cons
                (remove
                  '(m 0 -1 nil)
                  (second
                    (cons 'poly
                      (cons
                        (sum
                          (poly-ordering
                            (append
                              (mul-coefficients (monomials p2) (- 1))
                              (list p1)))) nil))) :test #'equal) nil)))

    ((is-monomial p2)
        (cons 'poly
              (cons
                (remove '(m 0 -1 nil)
                  (second (cons 'poly (cons (sum
                    (poly-ordering
                      (append
                        (mul-coefficients (list p2) (- 1))
                        (monomials p1)))) nil))) :test #'equal) nil)))

    ((and
      (is-polynomial p1)
      (is-polynomial p2))
        (cons 'poly
          (cons
            (remove
              '(m 0 -1 nil)
              (second (cons 'poly (cons (sum (poly-ordering
                        (append (mul-coefficients (monomials p2) (- 1))
                        (monomials p1)))) nil))) :test #'equal) nil)))

    (T "Error in poly-minus... Let's check the input")))

    (T (cons 'poly
              (cons
                (remove '(m 0 -1 nil)
                  (second
                    (polyminus (as-polynomial p1) (as-polynomial p2)))
                  :test #'equal) nil)))))

; DEFINIZIONE "mul-coefficients"

; La funzione "mul-coefficients" riceve in input due valori:
;   -una lista;
;   -un coefficiente moltiplicativo.
; La lista rappresenta chiaramente un polinomio (costituito
; quindi da una serie di monomi). La funzione moltiplica ogni
; coefficiente di ogni monomio contenuto all'interno del
; polinomio ricevuto input per il coefficiente moltiplicativo
; (chiaramente -1).

(defun mul-coefficients (l1 n)
  (cond
    ((null l1) l1)

    (T (cons (list 'm
                   (* (second (car l1)) n) (third (car l1))
                   (fourth (car l1)))

             ; La ricorsione viene qui utilizzata per reiterare
             ; l'operazione implementata dalla seguente
             ; funzione su ogni monomio costituente
             ; il polinomio ricevuto in input.
             (mul-coefficients (cdr l1) n)))))

; DEFINIZIONE "polytimes"

; La funzione "polytimes", superficialmente,
; si comporta esattamente come le
; funzioni "polysum" e "polyminus":
; per questo motivo verrà qui tralasciata
; la descrizione minuziosa di ogni passaggio del procedimento,
; rimandando il lettore alla consultazione dei commenti sopra
; definiti. Chairamente, ad essere qui di volta in volta
; invocata, sarà la funzione "times".

(defun polytimes (l1 l2)
(cond

  ((and
    (numberp l1)
    (numberp l2))
    (list 'poly
          (remove '(m 0 -1 nil)
            (second (polytimes (as-polynomial l1) (as-polynomial l2)))
          :test #'equal)))

  ((and
    (numberp l1)
    (is-polynomial l2))
    (list 'poly
          (remove '(m 0 -1 nil)
            (second (polytimes (as-polynomial l1) l2))
          :test #'equal)))

  ((and
    (is-polynomial l1)
    (numberp l2))
    (list 'poly
          (remove '(m 0 -1 nil)
            (second (polytimes l1 (as-polynomial l2)))
          :test #'equal)))

  ((and
    (numberp l1)
    (listp l2))
    (list 'poly
          (remove '(m 0 -1 nil)
            (second (polytimes (as-polynomial l1) (as-polynomial l2)))
          :test #'equal)))

  ((and
    (listp l1)
    (numberp l2))
    (list 'poly
          (remove '(m 0 -1 nil)
            (second (polytimes (as-polynomial l1) (as-polynomial l2)))
          :test #'equal)))

  ((or
    (equal (car l1) 'p)
    (equal (car l1) 'poly)
    (equal (car l1) 'm))

  (cond

    ((and
      (is-monomial l1)
      (is-polynomial l2))
      (cons 'poly
            (cons
              (poly-ordering (times (cons l1 nil) (second l2)))
              nil)))

      ((and
        (is-monomial l2)
        (is-polynomial l1))
        (cons 'poly
              (cons
                (poly-ordering (times (second l1) (cons l2 nil)))
                nil)))

        ((and
          (is-monomial l2)
          (is-monomial l1))
          (cons 'poly
                (cons
                  (poly-ordering (times (cons l1 nil) (cons l2 nil)))
                  nil)))

      ((and
        (is-polynomial l2)
        (is-polynomial l1))
        (polyplus (cons 'poly
                        (cons
                          (poly-ordering
                            (times (second l1) (second l2)))
                         nil))
                 '(m 0 -1 nil)))

      (T "Error in poly-minus... Let's check the input")))

  (T (cons 'poly
            (cons
              (remove '(m 0 -1 nil)
                (second
                  (polytimes (as-polynomial l1) (as-polynomial l2)))
              :test #'equal) nil)))))

; DEFINIZIONE "times"

; La funzione "times" riceve in input due liste di monomi ed
; effettua l'operazione di moltiplicazione.

(defun times (l1 l2)
  (cond

    ((null l1) nil)
    ((null l2) nil)

    ; Nel caso in cui la lista l1 contenesse un solo
    ; monomio semplicemente sarebbe possibile effettuare
    ; la moltiplicazione fra questo monomio e tutti
    ; quelli contenuti nella lista l2 richiamando la funzione
    ; "m-times".
    ((= (list-length l1) 1) (m-times l1 l2))

    ; Qualora la condizione precedentemente descritta non
    ; fosse soddisfatta bisognerebbe innanzitutto effettuare
    ; la moltiplicazione fra il primo monomio contenuto in l1
    ; e tutti i monomi contenuti in l2, bisognerebbe poi
    ; effettuare la moltiplicazione, applicando la ricorsione,
    ; fra i restanti monomi contenuti nella lista l1 e, di
    ; volta in volta, tutti quelli contenuti nella lista l2,
    ; unendo quindi i risultati in un'unica lista.
    (T (append
          (times (list (car l1)) l2)
          (times (cdr l1) l2)))))

; DEFINIZIONE "m-times"

; La funzione "m-times" riceve in input un monomio e una
; lista di monomi. Moltiplica quindi il monomio per ciascun
; monomio della lista e restituisce una lista
; contenente i monomi ottenuti mediante moltiplicazione.

(defun m-times (m l2)
  (cond

    ((null m) nil)
    ((null l2) nil)

    (T (cons

          ; Costruzione del "monomio prodotto". Moltiplica
          ; gli esponenti, somma i gradi totali, appende
          ; le varpowers dei due monomi e inserisce tutto nel
          ; contesto di una lista avente come primo argomento
          ; il carattere 'm.
          (list 'm
                (* (second (car m)) (second (car l2)))
                (+ (monomial-degree (car m))
                   (monomial-degree (car l2)))
                (sum-for-var
                  (append (fourth (car m)) (fourth (car l2)))))

           ; Reiterazione dell'operazione di moltiplicazione
           ; fra il monomio ricevuto in input
           ; e i restanti monomi della lista ricevuta in input.
           (m-times m (cdr l2))))))

; DEFINIZIONE "pprint-polynomial"

; La funzione "pprint-polynomial" riceve in input un polinomio
; in forma parsata e lo stampa a video in forma non parsata.
; La stampa a video è seguita, sulla stringa immediatamente
; successiva, dalla stringa "NIL"

(defun pprint-polynomial (p1)

  ; Viene qui richiamata la funzione "ppprint"
  ; alla quale viene passata una lista di monomi.
  (format t "~A" (ppprint (second p1)))
)

; DEFINZIONE "ppprint"

; La funzione "ppprint" riceve in input una lista di monomi
; ognuno dei quali nella forma parsata e richiamando
; ricorsivamente la funzione "monomial-tracting" su
; ciascuno di essi, li restituisce in forma non parsata.

(defun ppprint (p1)
  (cond
    ((= (list-length p1) 1) (monomial-tracting (car p1)))

    (T (one-level
          (list
            (monomial-tracting (car p1)) '+ (ppprint (cdr p1)))))))

; DEFINIZIONE "monomial-tracting"

; La funzione "monomial-tracting" riceve in input un monomio
; in forma parsata e si occupa semplicemente di restituirlo
; in forma non parsat. Adempie al proprio compito inserendo
; nell'ambito di una lista innanzitutto il coefficiente del
; monomio considerato e prosegue richiamando la funzione
; "inter" alla quale viene passata la "varpowers" del monomio
; stesso.

(defun monomial-tracting (m1)
  (one-level
    (list (monomial-coefficient m1)
          (inter (varpowers m1)))))

; DEFINIZIONE "inter"

; La funzione "inter" riceve in input una "varpowers"
; e, richiamando la funzione "adjust-vp", e
; quindi ricorsivamente anche se stessa restituisce
; ciascun elemento della struttura in forma non parsata.

(defun inter (vps)
  (cond
    ((null vps) nil)

    (T (cons (adjust-vp (car vps)) (inter (cdr vps))))))

; DEFINIZIONE "adjust-vp"

; La funzione "adjust-vp" semplicemente si occupa di eseguire
; una forma di "parsing inverso" e ricevuto un elemento di
; "varpowers" lo restituisce in forma non parsata. Adempie al
; proprio compito semplicemente inserendo nel contesto di una
; lista, rispettivamente, il simbolo dell'elemento,
; l'apice e quindi l'esponente dell'elemento stesso.

(defun adjust-vp (vp)
  (cond
    ((equal (varpower-power vp) 1) (list (varpower-symbol vp)))

    (T (list (varpower-symbol vp) '^ (varpower-power vp)))))

; DEFINZIONE "polyval"

; Purtroppo non si è riusciti ad implementare completamente
; questa funzione. E' stato effettuato un tentativo
; (dettagliatamente spiegato nel README) ma si è scelto
; di non utilizzarlo per le ragioni spiegate, ancora
; una volta nel README.

(defun polyval (p1 l1)
  "Please read file README...")
