import termkey
import termcurs
type
  LABEL_FMT1 {.pure.} = enum
    Lnom,
    Lanimal,
    Lprix,
    LGrid
  FIELD_FMT1 {.pure.}= enum
    Nom,
    Animal,
    Prix

const P_L1: array[LABEL_FMT1, int] = [0,1,2,3]

const P_F1: array[FIELD_FMT1, int] = [0,1,2]


func setID*( line : var int ) : string =
  line += 1
  return $line

initTerm(30,100)
setTerminal() #default color style erase

var pnlF1  = new(PANEL)
var grid  : GRIDSFL
var g_numID : int
var key : TKey = TKey.F1
var keyG : TKey_Grid
var startGrid :bool = false

while true:
  if key == TKey.F3 :  closeTerm()

  case key
  of TKey.F1:

    if not isActif(pnlF1) :  # init Panel
      pnlF1 = newPanel("nom",1,1,terminalHeight(),terminalWidth(),
      @[defButton(TKey.F3,"Exit"),defButton(TKey.F2,"Grid"),defButton(TKey.F9,"Add Row"),
      defButton(TKey.F23,"Delete Row All"),defButton(TKey.CtrlX,"Sel Ligne"),
      defButton(TKey.PageUP,""),defButton(TKey.PageDown,"")],CADRE.line0)

      pnlF1.label.add(defLabel($Nom, 2, 5,   "Nom.....:"))
      pnlF1.field.add(defString($Nom, 2, 5+(len(pnlF1.label[P_L1[Lnom]].text)), ALPHA, 20, "Jean-Pierre",FILL, "Nom Obligatoire", "Type Alpha a-Z"))

      pnlF1.label.add(defLabel($Animal, 4, 5,  "Animal..:"))
      pnlF1.field.add(defString($Animal, 4, 5+(len(pnlF1.label[P_L1[Lanimal]].text)), TEXT_FULL,30, "Chat",FILL, "Animale Obligatoire", "Type Alpha a-Z"))

      pnlF1.label.add(defLabel($Prix, 6, 5, "Prix....:"))
      pnlF1.field.add(defNumeric($Prix, 6, 5+(len(pnlF1.label[P_L1[Lprix]].text)), DECIMAL,5,2,"12.00",FILL, "Animale Obligatoire", "Type Alpha a-Z"))

      pnlF1.label.add(defLabel($Lgrid, 30, 90, ""))
      printPanel(pnlF1)

    key = ioPanel(pnlF1)

  of TKey.F2:
    if not startGrid :
      grid = newGrid("GRID01",10,1,5)
      var g_id      = defCell("ID",3,DIGIT)
      var g_name    = defCell("Name",getNbrcar(pnlF1,$Nom),ALPHA)
      var g_animal  = defCell("Fav animal",getNbrcar(pnlF1,$Animal),ALPHA)
      var g_prix    = defCell("Prix",getNbrcar(pnlF1,$Prix),DECIMAL)
      setCellEditCar(g_prix,"€")
      g_numID = - 1


      setHeaders(grid, @[g_id, g_name, g_animal,g_prix])
      addRows(grid, @[setID(g_numID), "Adam", "Cat, Aigle","50.00"])
      addRows(grid, @[setID(g_numID), "Eve" , "Cat, Papillon","50.00"])
      addRows(grid, @[setID(g_numID), "Roger", "Singe","50.00"])
      addRows(grid, @[setID(g_numID), "Ginette" , "Chien","50.00"])
      addRows(grid, @[setID(g_numID), "Maurice", "Dauphin","50.00"])
      addRows(grid, @[setID(g_numID), "Elisabhet" , "Oiseaux","50.00"])
      addRows(grid, @[setID(g_numID), "Eric", "Poisson","50.00"])
      addRows(grid, @[setID(g_numID), "Daniel" ,"Insect","50.00"])
      addRows(grid, @[setID(g_numID), "Mendi", "Chien","50.00"])
      addRows(grid, @[setID(g_numID), "Simon" ,"Scorpion","50.00"])

      #gotoXY(39,1) ; echo "60"; let y = getFunc();

      printGridHeader(grid)
      printGridRows(grid)
      startGrid = true
    key = TKey.F1

  of TKey.F9:
    if startGrid :
      addRows(grid,@[setID(g_numID), pnlF1.getText($Nom), pnlF1.getText($Animal),pnlF1.getText($Prix)])
      setLastPage(grid)
      printGridHeader(grid)
      printGridRows(grid)
    key = TKey.F1
  of TKey.F23:
    if startGrid :
      g_numID = -1
      grid = newGrid("GRID01",10,1,5)
      var g_id      = defCell("ID",3,DIGIT)
      var g_name    = defCell("Name",getNbrcar(pnlF1,$Nom),ALPHA)
      var g_animal  = defCell("Fav animal",getNbrcar(pnlF1,$Animal),ALPHA)
      var g_prix    = defCell("Prix",getNbrcar(pnlF1,$Prix),DECIMAL)
      setCellEditCar(g_prix,"€")
      g_numID = - 1
      setHeaders(grid, @[g_id, g_name, g_animal,g_prix])
      printGridHeader(grid)

    key = TKey.F1


  of TKey.PageUp :
    if startGrid :
      keyG = pageUpGrid(grid)
      if keyG == TKey_Grid.PGup:
        pnlF1.label[P_L1[Lgrid]].text = "Prior"
      else:
        pnlF1.label[P_L1[Lgrid]].text = "Home "
      displayLabel(pnlF1,pnlF1.label[P_L1[Lgrid]])
    key = TKey.F1

  of TKey.PageDown :
    if startGrid :
      keyG = pageDownGrid(grid)
      if keyG == TKey_Grid.PGdown:
        pnlF1.label[P_L1[Lgrid]].text = "Next "
      else:
        pnlF1.label[P_L1[Lgrid]].text = "End  "
      displayLabel(pnlF1,pnlF1.label[P_L1[Lgrid]])
    key = TKey.F1

  of TKey.Ctrlx :
    if startGrid :
      let (keys, val) = ioGrid(grid)
      #gotoXY(40,1) ; echo "99", keys, " val :", $val ; let n99 = getFunc();
      #gotoXy(40,1) ; echo "                                                                                                 "
      if keys == TKey.Enter :
        pnlF1.field[P_F1[Nom]].text = val[1]
        pnlF1.field[P_F1[Animal]].text = val[2]
        pnlF1.field[P_F1[Prix]].text = val[3]
        displayField(pnlF1, pnlF1.field[P_F1[Nom]])
        displayField(pnlF1, pnlF1.field[P_F1[Animal]])
        displayField(pnlF1, pnlF1.field[P_F1[Prix]])
      elif keys == TKey.Escape:
        printGridHeader(grid)
        printGridRows(grid)
    key = TKey.F1

  else : discard