



(
{
    var w, x, y, z, p;

	w=(InFeedback.ar(3)+InFeedback.ar(4)++InFeedback.ar(5))/2.sqrt;

	x=InFeedback.ar(3);

	y=InFeedback.ar(4);

	z=InFeedback.ar(5);

    // B-format decode to stereo with speakers at different distances
    BFDecode1.ar1(w, x, y, z, [0.degrad, 90.degrad], 0,4 );

}.scope(2);
)


//manual
///weights can be cartesian
(
{
    var w, x, y, z;
    var left, right;

    #w, x, y, z = SoundIn.ar([0,1,2,3]);

    left  = w + 0.5*x + 0.5*y + 0.2*z;
    right = w + 0.5*x - 0.5*y + 0.2*z;

    [left, right] * 0.5
}.play;
)
Buffer.freeAll;
(
~c1 = Buffer.readChannel(s,,channels:0);
~c2 = Buffer.readChannel(s,,channels:1);
~c3 = Buffer.readChannel(s,,channels:2);
~c4 = Buffer.readChannel(s,,channels:3);
);
(
{
    var w, x, y, z, p;

	w=1*PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0,doneAction:2)*2.sqrt;
	x=1*PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0,doneAction:2)*2.sqrt;
	y=1*PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0,doneAction:2)*2.sqrt;
	z=1*PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0,doneAction:2)*2.sqrt;

	x=x*z;
	y=y*z;

    // B-format decode to stereo with speakers at different distances
Out.ar(0,DecodeB2.ar(2,w, x, y,0.5).fold2(1));

}.play;
s.record(numChannels:2,duration:((9*60)+10));
)
