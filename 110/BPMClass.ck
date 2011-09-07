public class TIME
{
    dur myDurations[14];    
    
    fun void tempo(float bpm)
    {
        
        (120.0 / bpm)::second => dur half @=> myDurations["half"];
        (60 / bpm)::second => dur quarter @=> myDurations["quarter"];
        (30 / bpm)::second => dur eighth @=> myDurations["eighth"];
        (15 / bpm)::second => dur sixteenth @=> myDurations["sixteenth"];
        (7.5 / bpm)::second => dur thirtysecond @=> myDurations["thirtysecond"];
        (3.75 / bpm)::second => dur sixtyfourth @=> myDurations["sixtyfourth"];
        (90 / bpm)::second => dur dQuarter @=> myDurations["dQuarter"];
        (45 / bpm)::second => dur dEighth @=> myDurations["dEighth"];
        (22.5 / bpm)::second => dur dSixteenth @=> myDurations["dSixteenth"];
        (1.25 / bpm)::second => dur dThirtySecond @=> myDurations["dThirtySecond"];
        (80.0 / bpm)::second => dur tHalf @=> myDurations["tHalf"];
        (40 / bpm)::second => dur tQuarter @=> myDurations["tQuarter"];
        (20 / bpm)::second => dur tEighth @=> myDurations["tEighth"];
        (10 / bpm)::second => dur tSixteenth @=> myDurations["tSixteenth"];
        (5 / bpm)::second => dur tThirtysecond @=> myDurations["tThirtysecond"];
        (2.5 / bpm)::second => dur tSixtyforth @=> myDurations["tSixtyforth"];
        
        
    }
}