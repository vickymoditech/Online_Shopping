package Add_To_Cart;
public class Cart 
{
    public int pid;
    public String p_name;
    public int p_price;
    public int p_qty;
    public String p_img;
    public String p_company;
    public int product_qty;
    
    public Cart(int pid,String p_name,int p_price,int p_qty,String p_img,String p_company,int product_qty)
    {
        this.pid = pid;
        this.p_name = p_name;
        this.p_price = p_price;
        this.p_qty = p_qty;
        this.p_img  = p_company;
        this.p_img = p_img;
        this.product_qty = product_qty;
    }        
}
