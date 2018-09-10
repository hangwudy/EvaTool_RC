# EvaTools for Rotation Clinching
Evaluation tools(Auswertungstool) for rotation clinching in Matlab

Rotation clinching is a new type of clinching developed by *utg* at TUM.

## Evaluation Tool
```Auswertungstool.m``` is the main file for the evaluation of the simulation results from ABAQUS.
It should be used with ```Auswertungstool.fig``` and ```CP_Analyse.m```.

Interface of the Evaluation Tool:

![alt text](https://github.com/hangwudy/EvaTool_RC/blob/master/Interface/Auswertungstool_GUI.PNG "Interface")

You can find the instruction for use [here](https://github.com/hangwudy/EvaTool_RC/blob/master/EvaluationTool/GUI_Introduction_rev_0.pdf).

## Extration Tool
```Kontur.m``` is the main file to extract the edge information. It should be used in conjuction with ```Kontur.fig```, ```Analysis.m``` and ```Analysis_SIMULATION.m```. The first file is the GUI file of the programm. The latter two are the analytical functions for the main file.


Interface of the Extration Tool:

![alt text](https://github.com/hangwudy/EvaTool_RC/blob/master/Interface/Kontur_GUI.PNG "Interface")

You can do the test with the attached picture.

The usage for Kontur.m will be updated later. Thanks for your interest.
