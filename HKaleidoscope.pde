/* Basic kaleidoscope mirroring borrowed from 
   http://www.openprocessing.org/sketch/39093 */
public static class HKaleidoscope extends HDrawable {

	private float _rotationSpeed = .00008;

	private int _sides = 7;
	private int _scopeRadius = H.app().width / 2;
	 
	private float _mirrorRadians = 0;
	private int _subImageHeight = 0;
	private int _subImageWidth = 0;
	 
	private PGraphics _subImageToBeWedged;
	private PGraphics _wedgeMask;
	 
	private boolean _useMirrors = true;
	private boolean _on = true;

	private int _backgroundColor;

	public HKaleidoscope() {

		setupMirror();
	}

	public HKaleidoscope sides(int sides) {
		_sides = sides;
		setupMirror();
		return this;
	}

	public int sides() {
		return _sides;
	}

	public HKaleidoscope rotationSpeed(float rotationSpeed) {
		_rotationSpeed = rotationSpeed;
		return this;
	}

	public float rotationSpeed() {
		return _rotationSpeed;
	}

	public HKaleidoscope useMirrors(boolean useMirrors) {
		_useMirrors = useMirrors;
		return this;
	}

	public boolean useMirrors() {
		return _useMirrors;
	}

	public HKaleidoscope on(boolean on) {
		_on = on;
		return this;
	}

	public boolean on() {
		return _on;
	}

	public HKaleidoscope createCopy() {
		HKaleidoscope copy = new HKaleidoscope();
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public void draw( PGraphics g, boolean usesZ,
		float drawX,float drawY,float alphaPc) {

		if(!_on) {
			return;
		}

	  	PImage img = g.get(g.width/2, g.height/2, _subImageWidth, _subImageHeight);
	  	_subImageToBeWedged.beginDraw();
	  	_subImageToBeWedged.image(img,0,0);
	  	_subImageToBeWedged.endDraw();

	  	
		 if (_useMirrors)
		    _subImageToBeWedged.mask(_wedgeMask);

		g.clear();
		  g.pushMatrix();
		    g.translate(g.width/2, g.height/2);
		    // rotating of scope as a whole
		    H.app().rotate(H.app().millis() * _rotationSpeed);    
		    if (_useMirrors) {
		      for (int i = 0; i < _sides; ++i)
		      {
		        // for each reflection
		        g.pushMatrix();
		          g.rotate(_mirrorRadians*i*2);
		          g.image(_subImageToBeWedged, 0, 0);
		          g.scale(1,-1);
		          g.image(_subImageToBeWedged, 0, 0);
		        g.popMatrix();
		      }
		    }
		    else {
		        g.image(_subImageToBeWedged, 0, 0);
		    }
		  g.popMatrix();
	}


	 
	         
	void setupMirror()
	{
	    _mirrorRadians = 2*PI / (_sides*2);
	 
	    _subImageWidth = _scopeRadius;
    	_subImageHeight = ceil(sin(_mirrorRadians)*_scopeRadius);

	    _subImageToBeWedged = H.app().createGraphics(_subImageWidth, _subImageHeight, P2D);
	    _wedgeMask = H.app().createGraphics(_subImageWidth, _subImageHeight, P2D);
	   
	    _wedgeMask.beginDraw();
	      _wedgeMask.smooth();
	      _wedgeMask.background(0);
	      _wedgeMask.fill(255);
	      _wedgeMask.stroke(255); 
	      _wedgeMask.beginShape();
		      _wedgeMask.vertex(0,0);
		      _wedgeMask.curveVertex(_scopeRadius,0);
		      _wedgeMask.curveVertex(_scopeRadius,0);
		      _wedgeMask.curveVertex(cos(_mirrorRadians*.5)*_scopeRadius, sin(_mirrorRadians*.5)*_scopeRadius);
		      _wedgeMask.curveVertex(cos(_mirrorRadians)*_scopeRadius, sin(_mirrorRadians)*_scopeRadius);
		      _wedgeMask.curveVertex(cos(_mirrorRadians)*_scopeRadius, sin(_mirrorRadians)*_scopeRadius);
	      _wedgeMask.endShape(CLOSE);
	    _wedgeMask.endDraw();
	}
}