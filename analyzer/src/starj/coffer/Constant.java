package starj.coffer;

public abstract class Constant {
    public static final byte CONSTANT_Utf8               = 1;
    public static final byte CONSTANT_Integer            = 3;
    public static final byte CONSTANT_Float              = 4;
    public static final byte CONSTANT_Long               = 5;
    public static final byte CONSTANT_Double             = 6;
    public static final byte CONSTANT_Class              = 7;
    public static final byte CONSTANT_String             = 8;
    public static final byte CONSTANT_Fieldref           = 9;
    public static final byte CONSTANT_Methodref          = 10;
    public static final byte CONSTANT_InterfaceMethodref = 11;
    public static final byte CONSTANT_NameAndType        = 12;

    private byte tag;

    public Constant(byte tag) {
        this.tag = tag;
    }

    public byte getTag() {
        return this.tag;
    }

    boolean isConcrete() { // Overriden in LazyConstant
        return true;
    }
}
