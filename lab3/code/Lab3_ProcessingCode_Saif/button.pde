public class Button {
    String name;
    String iconLocation;
    int keyCode;
    float x;
    float y;

    public Button(){
        this.name = "";
        this.iconLocation = ".";
        this.keyCode = 0;
        this.x = 0.0;
        this.y = 0.0;
    }
    public Button(String name, String iconLocation, int keyCode, float x, float y){
        this.name = name;
        this.iconLocation = iconLocation;
        this.keyCode = keyCode;
        this.x = x;
        this.y = y;
    }

    public String getName() {return name;}
    public String getIconLocation() {return iconLocation;}
    public int getKeyCode() {return keyCode;}
    public float getX() {return x;}
    public float getY() {return y;}

    public void setName(String name) {this.name = name;}
    public void setIconLocation(String iconLocation) {this.iconLocation = iconLocation;}
    public void setKeyCode(int keyCode) {this.keyCode = keyCode;}
    public void setX(float x) {this.x = x;}
    public void setY(float y) {this.y = y;}
}
