package Checking_code;

import database.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
//import javassist.bytecode.Descriptor;
import javax.print.attribute.HashAttributeSet;

public class top_category_sold {

    public static void main(String args[])
    {
        try {
            
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            
            int total = 0;
            ResultSet rs = st.executeQuery("select count(distinct p_id) from tbl_order_detail");
            while(rs.next())
            {
                total = rs.getInt(1); 
            }
            
            int [] pid = new int[total];
            int [] user_qty  = new int[total];
            
            int index = 0;
            
            rs = st.executeQuery("select distinct p_id from tbl_order_detail");
            while (rs.next())
            {
                int p_id = rs.getInt(1);
                Statement st1 = cnn.createStatement();
                ResultSet rs1 = st1.executeQuery("select sum(user_qty) from tbl_order_detail where p_id = " + p_id);
                while (rs1.next())
                {
                    pid[index] = p_id;
                    user_qty[index] = rs1.getInt(1);
                }
                index ++;
            }
            
            
            // shorting program 
            
            for(int i=0;i<user_qty.length;i++)
            {
                for(int j=0;j<user_qty.length;j++)
                {
                    if(user_qty[i]>user_qty[j])
                    {
                        int tmp = pid[i];
                        int tmp1 = user_qty[i];
                        
                        pid[i] = pid[j];
                        user_qty[i] = user_qty[j];
                        
                        pid[j] = tmp;
                        user_qty[j] = tmp1;
                    }
                }
            }
            
            
            for(int i=0;i<pid.length;i++)
            {
                System.out.print(pid[i]+" ");
                System.out.println(user_qty[i]);
            }
            
             
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }
}
