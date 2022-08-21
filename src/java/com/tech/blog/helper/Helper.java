package com.tech.blog.helper;

import java.io.*;

/**
 *
 * @author DELL
 */
public class Helper {
    
    public static boolean deleteFile(String path)
    {
        // make static so that we can call it by using class name .
        boolean f=false;
        
        try{
            File file = new File(path);
            
            f = file.delete();  // file.delete() file and directory  ( it return true if and only if file and directory successfully deleted ) .
            // so  agar file delete ho jayegi toh f true ho jayega nahi toh false he rahega .
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        return f;   
    }
    
    public static boolean saveFile(InputStream is , String path)   // yeh function iss (is) se data ko read karke iss path par write kardega . 
    {
        boolean f=false;
        
        try{
            
            byte b[] = new byte[is.available()];
            
            is.read(b);  // yeh is se read karke byte ke array b mein rakh dega .
            
// ab data write karna hai apne path pe (path wale file mein )
            
            FileOutputStream fo = new FileOutputStream(path);
            
            fo.write(b);
                
            fo.flush();
            fo.close();
              
            f=true;
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        return f;   
    }
    
    
    
}
