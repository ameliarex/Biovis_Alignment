README
---
A4: Structure of Biology - 1D Sequence
---
BCB 4002 Tete Zhang

**Visualization Design**

In the visualization design, the match/mismatch can be observed by looking at the matching position of the first line of sequence and the second. If the characters are the same, it is a match; otherwise it is a mismatch. Insertion/deletion is represented by an alignment of a letter and a "-" sign. Depending on which sequence is treated as the baseline sequence, the "-" can be interpreted as a deletion, or the aligned letter can be interpreted as an insertion. 

The correct alignment also based on the choice of monospaced font. By using a font in which all letters have the same width, the alignment is displayed correctly. 

The sequence will be wrapped to the next line if its length exceeds the width of the display window. Each line displays 250 characters of the alignment and continues to the next line. Without scrolling, the display can hold around 10000 characters of alignment. The code needs further development for sequences longer than 10000 characters. 

**Source of Code**

The string sample was found in the rna_coding.fasta file attached. The file is part of the Ensembl.org database. However the string used in the visualization was copied into the processing code to simplify the process of data reading. 

**Beyond the Requirement Components**

The scale of the alignment display is handled to some degree. In a 1200X1200 screen, 10000 characters of alignment can be displayed.

**Instructions**

Download the hw4.pde file and run it in Processing. 

