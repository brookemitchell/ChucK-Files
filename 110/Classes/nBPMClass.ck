public class TIME
{
    dur myDurations[14];    
    
    fun void tempo(float bpm){
        
        (120.0 / bpm)::second @=>  myDurations["half"];
        (60 / bpm)::second @=>  myDurations["quarter"];
        (30 / bpm)::second @=>  myDurations["eighth"];
        (15 / bpm)::second @=>  myDurations["sixteenth"];
        (7.5 / bpm)::second @=>  myDurations["thirtysecond"];
        (3.75 / bpm)::second @=>  myDurations["sixtyfourth"];
        (90 / bpm)::second @=>  myDurations["dQuarter"];
        (45 / bpm)::second @=> myDurations["dEighth"];
        (22.5 / bpm)::second @=>  myDurations["dSixteenth"];
        (1.25 / bpm)::second @=> myDurations["dThirtySecond"];
        (40 / bpm)::second @=> myDurations["tQuarter"];
        (20 / bpm)::second @=> myDurations["tEighth"];
        (10 / bpm)::second @=> myDurations["tSixteenth"];
        (5 / bpm)::second @=> myDurations["tThirtysecond"];
        (2.5 / bpm)::second  @=> myDurations["tSixtyforth"];
                    
        
    }
}