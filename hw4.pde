// BCB 4002
// Assignment 4: Alignment
// Tete Zhang

//Alignment Subject Sequence
String sq1 = "GGGCCCTTTCTTCCGTTTGAACGTAAAGGCATTTTTGAGACCATTA" + 
"CCAAACCTAGCAAATAAACCGGGAGGCTTGACTGCTCGTAGGGATTGTGGTTGATATGC" + 
"ATCTGAGTCGAATCTATTGGCATTCCAAGACGTTTGGTCGTCATGGTTATTGCTCATAA" + 
"ATAGATTTTCATGGACATCATTTTCAATGTTATCATCATCAGCGTCTAAGTCGATAGTC" + 
"TCTTCGGGAAGTACATGACTTGGTGGTATATAATTCGCGTTCGCATGTGAGTTGGTGAC" + 
"CTTTGAACGGGATCCAGAATGAGAAGTCGTGTCGTCTAAGAAGTCAATATCGAAAAGCG" + 
"TGTCGTCCTCCCCAGGTTTCCTCTTTGGGGGGGTTTCTCTGTCGTCATTCATGGTAAAA" + 
"TCAGGGAATGAAAGAACCTACCAGTAAATTATTGCTTGGCGCTAACCTCTATTTGGCGT" + 
"TACTGGCTTCTTGTTGCACTATTCCCCTTAGAATTGCCAACAATTGTTGATTATATGTT" + 
"TCTTCAACTTAGTGGCATTAAACAGATTTGGGTTTTCTGGCAAAAA";

String sq2 = "ATTGCACAACTTAAGTTTGTCGAGGATCATTTTTTTGAACTGAATC" + 
"ATGCTCTTTTTAAGTGCTTTGAAACCCTCGATGAATGTGTCAATGTGCAAAGATAAACC" + 
"ATTGTTCTCTGTTGATCAGTGACTTAATGTTTGCTTTGGAGAATGATATTTTCCCTTTC" + 
"CTATATTTGACTTTTGTTCTAAAAGTTATTTGGAGAGAAAAGGCATGATTGAGGTTGCG" + 
"ACTTTTTCGTTTTTGCTTTTGCATGGATAATTCATCCATGCACATCTCACTTTATTGGA" + 
"CCTTCAAGATTGGTTTCCCATGTAATTTAATTTTCTCTCCTCTACATTTAATATGTTCT" + 
"ATATTAATTAATACCAATTGAGTTGTGCGTACTTCATTGCAGATATTTTACCAGACCTG" + 
"TCTGAGTTTTTCGTTCAAGTTTGGTTGAAATCGGCTTGAGGTATATGAACGTGGTTGGG" + 
"ATATGGAGATTGGGAGATCAAAGAAGCGAAAATACCTGAGACAGTTTTTTTAAAAAAGA" + 
"AGCTAAGGAACATGACTCAAAGAGACACATTA";

//Experimental Sequence
//String sq1 = "GAATTCAGTTA";
//String sq2 = "GGATCGA";

//the class representing a cell of the score matrix
class Cell {
  Cell preCell;//the cell that the pointer points to 
  int score;// the score of the sequence alignment at this position
  int row;//row number of the position
  int col;//column number of the position
  
  Cell(int i, int j) {
    preCell = null;
    score = 0;
    row = i;
    col = j;
  }
  
  //function that sets the score of the position
  void setScore(int i) {
    score = i;
  }
  
  //function that gets the score of the position
  int getScore() {
    return score;
  }
  
  //function that gets the row number of the position
  int getrow() {
    return row;
  }
  
  //function that gets the column number of the position
  int getcol() {
    return col;
  }
  
  //function that sets the pointer cell of the position
  void setPreCell(Cell c) {
    preCell = c;
  }
  
  //function that gets the pointer cell of the position
  Cell getPreCell() {
    return preCell;
  }
}

// set up the matrix
Cell[][] score = new Cell[sq2.length()+1][sq1.length()+1];

// scoring scheme
// +2 for a match
// -1 for a mismatch
// -2 for a gap
int match = 2;
int mismatch = -1;
int gap = -2;

//display font
PFont mono = createFont("Courier",7);

void setup(){
  //basics
  //size(1200,350);
  stroke(0);
  fill(0);
  background(230,230,250);
  
  //initialize the matrix
  iniTable();
  //fill in each cell of the matrix
  fillIn();
  //store the result of the trace back function to a string array
  String[] display = traceBack();
  
  int height = floor(display[0].length()/250)+1;
  
  //set the size of the window according to the length of the sequence
  size(1200, (height+1)*20);
  
  //display the sequence that can be equally divided by 250
  for (int i=0; i<display[0].length()-250;i = i + 250) {
    String sec1 = "";
    String sec2 = "";
    for (int j = 1; j<251; j++) {
      sec1 = sec1+display[0].charAt(i+j-1);
      sec2 = sec2+display[1].charAt(i+j-1);
    }
    textFont(mono);
    text(sec1, 10,10+i/250*30);
    textFont(mono);
    text(sec2, 10,20+i/250*30);
  }
  
  //display the rest of the sequence
  String sec3 = "";
  String sec4 = "";
  
  for (int i = (height-1)*250+1; i<display[0].length(); i++){
    sec3 = display[0].charAt(i)+sec3;
    sec4 = display[1].charAt(i)+sec4;
  }
  
  textFont(mono);
  text(sec3, 10,height*20+10);
  textFont(mono);
  text(sec4, 10,height*20+20);

}

//function that initialize the scoring matrix
void iniTable() {
  for (int i=0; i< sq2.length()+1; i++){
    for (int j=0; j<sq1.length()+1; j++){
      //initialize all matrix cell to a Cell Object
      score[i][j] = new Cell(i,j);
      //set all scores to zero
      score[i][j].setScore(0);
    }
  }
}

//function that fills in the scoring matrix
void fillIn() {
  for (int i=1; i< sq2.length()+1; i++){
    for (int j=1; j<sq1.length()+1; j++){
      //set the relative positions of a cell
      Cell current = score[i][j];
      Cell above = score[i-1][j];
      Cell left = score[i][j-1];
      Cell diag = score[i-1][j-1];
      //fill in the cells
      fillScore(current, above, left, diag);
    }
  }
}

//function that does the filling
void fillScore(Cell current, Cell above, Cell left, Cell diag) {
  //scores for different conditions
  int rowGapScore = above.getScore() + gap;//gap in the same row
  int colGapScore = left.getScore() + gap;//gap in the same column
  int alignScore = diag.getScore();//no gap;match or mismatch
  
  //calculate the score if match or mismatch
  if (sq2.charAt(current.getrow()-1) == 
      sq1.charAt(current.getcol()-1)) {
        alignScore += match;
      }
  else {
    alignScore += mismatch;
  }
  
  //set the score for all the cells
  //max(match/mismatch, gap in row, gap in column);
  if (rowGapScore >= colGapScore) {
    if (alignScore >= rowGapScore) {
      current.setScore(alignScore);
      current.setPreCell(diag);
    }
    else {
      current.setScore(rowGapScore);
      current.setPreCell(above);
    }
  }
  else {
    if (alignScore >= colGapScore) {
      current.setScore(alignScore);
      current.setPreCell(diag);
    }
    else {
      current.setScore(colGapScore);
      current.setPreCell(left);
    }
  }
}

//trace back function in dynamic programming
String[] traceBack() {
  //set the alignment strings
  String align1 = "";
  String align2 = "";
  //set the current cell (lower right corner of the scoring matrix)
  Cell current = score[sq2.length()][sq1.length()];
  
  //loop through the pointers and create alignments
  while (current.preCell != null) {
    if (current.getrow() - current.getPreCell().getrow() == 1) {
      align2 = sq2.charAt(current.getrow() - 1) + align2;
    }
    else {
      align2 = "-" + align2;
    }
    if (current.getcol() - current.getPreCell().getcol() == 1) {
      align1 = sq1.charAt(current.getcol() - 1) + align1;
    }
    else {
      align1 = "-" + align1;
    }
    current = current.getPreCell();
  }
  
  //combines the results to final alignment
  String[] alignment = new String[] {align1.toString(),align2.toString()};
  return alignment;

}

