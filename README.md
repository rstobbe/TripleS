# TripleS (Sodium Spin Simulator)

This app was used to model sodium MRI relaxation weighting (Stobbe et al, Frontiers in Neurology, 2021). 

### To generate Table 2 values

* "Retreive Seq" - select sequence (.mat file) from within Sequences folder
* "Load" - select up to three models (.mat files) from within Models folder
* "GO" - Mxy values are shown for each model (relative to Mo = 1)
* Divide Mxy values by sin(FlipAngle) to attain relative NaMRI weightings 

### Options

* Sequence elements can be added and changed and new sequences saved.
* "Plot Seq" - plot magnetic momement evolution associated with tensor operators selected. 
* "Segment Sequence" can be used to solve the sequence over smaller intervals (or smaller Step values).  This only has value for sequence plotting purposes. 

### Other

* This app is in the process of being updated and some additional features (including off-resonance) are not available