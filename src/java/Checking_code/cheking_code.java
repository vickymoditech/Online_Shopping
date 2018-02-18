package Checking_code;
import java.util.*;
import database.Database_connection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.spi.DirStateFactory;

class product
{
    public int pid;
    public String p_name;
    public int p_price;
    public int p_qty;
    public String p_img;
    public String p_company;
    
    public product(int pid,String p_name,int p_price,int p_qty,String p_img,String p_company)
    {
        this.pid = pid;
        this.p_name = p_name;
        this.p_price = p_price;
        this.p_qty = p_qty;
        this.p_img  = p_company;
        this.p_img = p_img;
    }
    
}

public class cheking_code 
{
    public static void main(String args[]) throws Exception
    {
        Database_connection obj_connection = new Database_connection();
        Connection cnn = obj_connection.cnn;
        Statement st = cnn.createStatement();
        ResultSet rs = st.executeQuery("select * from tbl_product");
        HashMap<Integer,product> al = new HashMap<Integer, product>();
        while(rs.next())
        {
            int tmp = rs.getInt(1);
            al.put(tmp,new product(tmp,rs.getString(3),rs.getInt(5),2,rs.getString(7),rs.getString(8)));
        }
      
        for(int i : al.keySet())
        {
            product tmp = (product) al.get(i);
            System.out.println(tmp.p_img);
        }
        
        al.remove(1);
        
        for(int i : al.keySet())
        {
            product tmp = (product) al.get(i);
            System.out.println(tmp.p_img);
        }
        
        
        
        
    }
}
