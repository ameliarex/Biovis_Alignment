// BCB 4002
// Assignment 4: Alignment
// Tete Zhang

//String sq1 = "GGGCCCTTTCTTCCGTTTGAACGTAAAGGCATTTTTGAGACCATTA" + 
//"CCAAACCTAGCAAATAAACCGGGAGGCTTGACTGCTCGTAGGGATTGTGGTTGATATGC" + 
//"ATCTGAGTCGAATCTATTGGCATTCCAAGACGTTTGGTCGTCATGGTTATTGCTCATAA" + 
//"ATAGATTTTCATGGACATCATTTTCAATGTTATCATCATCAGCGTCTAAGTCGATAGTC" + 
//"TCTTCGGGAAGTACATGACTTGGTGGTATATAATTCGCGTTCGCATGTGAGTTGGTGAC" + 
//"CTTTGAACGGGATCCAGAATGAGAAGTCGTGTCGTCTAAGAAGTCAATATCGAAAAGCG" + 
//"TGTCGTCCTCCCCAGGTTTCCTCTTTGGGGGGGTTTCTCTGTCGTCATTCATGGTAAAA" + 
//"TCAGGGAATGAAAGAACCTACCAGTAAATTATTGCTTGGCGCTAACCTCTATTTGGCGT" + 
//"TACTGGCTTCTTGTTGCACTATTCCCCTTAGAATTGCCAACAATTGTTGATTATATGTT" + 
//"TCTTCAACTTAGTGGCATTAAACAGATTTGGGTTTTCTGGCAAAAA"
//
//String sq2 = "ATTGCACAACTTAAGTTTGTCGAGGATCATTTTTTTGAACTGAATC" + 
//"ATGCTCTTTTTAAGTGCTTTGAAACCCTCGATGAATGTGTCAATGTGCAAAGATAAACC" + 
//"ATTGTTCTCTGTTGATCAGTGACTTAATGTTTGCTTTGGAGAATGATATTTTCCCTTTC" + 
//"CTATATTTGACTTTTGTTCTAAAAGTTATTTGGAGAGAAAAGGCATGATTGAGGTTGCG" + 
//"ACTTTTTCGTTTTTGCTTTTGCATGGATAATTCATCCATGCACATCTCACTTTATTGGA" + 
//"CCTTCAAGATTGGTTTCCCATGTAATTTAATTTTCTCTCCTCTACATTTAATATGTTCT" + 
//"ATATTAATTAATACCAATTGAGTTGTGCGTACTTCATTGCAGATATTTTACCAGACCTG" + 
//"TCTGAGTTTTTCGTTCAAGTTTGGTTGAAATCGGCTTGAGGTATATGAACGTGGTTGGG" + 
//"ATATGGAGATTGGGAGATCAAAGAAGCGAAAATACCTGAGACAGTTTTTTTAAAAAAGA" + 
//"AGCTAAGGAACATGACTCAAAGAGACACATTA"

String sq1 = "GAATTCAGTTA";
String sq2 = "GGATCGA";

// scoring scheme
// +2 for a match
// -1 for a mismatch
// -2 for a gap

void setup(){
  
  //basics
  size(350,350);
  stroke(0);
  fill(0);
  background(230,230,250);

  int[][] matrix = new int[sq2.length()+1][sq1.length()+1];
  int[][] score = new int[sq2.length()+1][sq1.length()+1];
  
  StringList link = new StringList();
  
  for (int i=0;i<sq2.length()+1; i++){
    matrix[i][0] = 0;
    score[i][0] = 0;
  }
  for (int j=0;j<sq1.length()+1; j++){
    matrix[0][j] = 0;
    score[0][j] = 0;
  }
  
  for (int i=1;i<sq2.length()+1;i++){
    for (int j=1; j<sq1.length()+1;j++) {
      if (sq2.charAt(i-1) == sq1.charAt(j-1)){
        matrix[i][j] = 2; 
      }
      else{
        matrix[i][j] = -1;
      }
    }
  }
  for (int i=1;i<sq2.length()+1;i++){
    for (int j=1; j<sq1.length()+1;j++) {
      
      score[i][j] = max(score[i-1][j-1]+matrix[i][j], 
                        score[i][j-1] - 2,
                        score[i-1][j] - 2);
                        
      if(score[i][j] == score[i-1][j-1]+matrix[i][j]){
           link.append(str(i-1) + "," + str(j-1));
      }
      if (score[i][j] == score[i][j-1]-2){
           link.append(str(i) + "," + str(j-1));
      }
      if (score[i][j] == score[i-1][j]-2) {
           link.append(str(i-1) + "," + str(j));
      }
         
    }
  }
  println(score[4][4]);
  println(link.size());
  String[] linka = link.array();
  println(linka);
  
  if (first(link.get(link.size()-1)
  text(str(sq1.charAt(sq1.length()-1)), 300,50);
  line(304,55,304,65);
  text(str(sq2.charAt(sq2.length()-1)), 300,80);


}

int first(String s) {
  String[] a = split(s, ",");
  return int(a[0]);
}

int last(String s) {
  String[] a = split(s, ",");
  return int(a[s.length()-1]);
}
    

