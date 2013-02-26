abstract class Agent {

    protected State mState;

    abstract void loop(); /* calculations here */


    abstract void draw(); /* visualization here */


    abstract Vector3f position();

    protected void changeState(State pState) {
        if (mState != null) {
            mState.terminate();
        }
        mState = pState;
        mState.begin();
    }
}
