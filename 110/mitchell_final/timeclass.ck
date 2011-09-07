//Allan Mitchell 300214807 CMPO 110 Fianl Assign


//All the best times of my life.... go easy on the bpm...

public class TIME
{
    dur dur[17];    
    
    fun dur[] temposet(float bpm)
    {
        (240.0 / bpm)::second @=> dur[0] @=> dur["bar"];
        (120.0 / bpm)::second @=> dur[1] @=> dur["half"];
        (90 / bpm)::second @=> dur[2] @=> dur["dQuarter"];
        (80.0 / bpm)::second @=> dur[3] @=> dur["tHalf"];
        (60 / bpm)::second @=> dur[4] @=> dur["quarter"];
        (45 / bpm)::second @=> dur[5] @=> dur["dEighth"];
        (40 / bpm)::second @=> dur[6] @=> dur["tQuarter"];
        (20 / bpm)::second @=> dur[7] @=> dur["tEighth"];
        (10 / bpm)::second @=> dur[8] @=> dur["tSixteenth"];
        (30 / bpm)::second @=> dur[9] @=> dur["eighth"];
        (22.5 / bpm)::second @=> dur[10] @=> dur["dSixteenth"];
        (15 / bpm)::second @=> dur[11] @=> dur["sixteenth"];
        (7.5 / bpm)::second @=> dur[12] @=> dur["thirtysecond"];
        (5 / bpm)::second @=> dur[13] @=> dur["tThirtysecond"];
        (3.75 / bpm)::second @=> dur[14] @=> dur["sixtyfourth"];
        (2.5 / bpm)::second @=> dur[15] @=> dur["tSixtyforth"];  
        (1.25 / bpm)::second @=> dur[16] @=> dur["dThirtySecond"];
        
        return dur;   
    }
}