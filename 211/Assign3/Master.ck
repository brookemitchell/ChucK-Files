//Master.ck

//Add all classes first
Machine.add("OscHandler.ck");

//And then add sound generators
Machine.add("AddSynth.ck");
Machine.add("FMSynth.ck");

//OscHandler osc;
AddSynth add; 
FMSynth fm;
1::day => now;
