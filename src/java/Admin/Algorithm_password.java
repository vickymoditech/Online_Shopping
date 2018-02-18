package Admin;

public class Algorithm_password {

    public Algorithm_password() {
    }

    public String Encrypt_password(String msg) {
        String pass = "";
        if (msg.length() < 30) {
            for (int i = 0; i < 30; i++) {
                if (i < msg.length()) {
                    pass += msg.charAt(i);
                } else {
                    pass += 'A';
                }
            }
        }


        System.out.println(pass.length());
        char[][] rows = new char[6][5];
        char[][] tmp = new char[6][5];
        char[][] ans = new char[6][5];
        int nextchar = 0;
        for (int i = 0; i < 6; i++) {
            for (int j = 0; j < 5; j++) {
                rows[i][j] = pass.charAt(nextchar);
                nextchar++;
            }
        }
        // row changes
        String data2 = "530142";

        for (int i = 0; i < 6; i++) {
            String splitdataright = Character.toString(data2.charAt(i));
            int index2 = Integer.parseInt(splitdataright);
            for (int k = 0; k < 5; k++) {
                tmp[i][k] = rows[index2][k];
            }
        }

        data2 = "43021";

        for (int i = 0; i < 5; i++) {
            String splitdataright = Character.toString(data2.charAt(i));
            int index2 = Integer.parseInt(splitdataright);
            for (int k = 0; k < 6; k++) {
                ans[k][i] = tmp[k][index2];
            }
        }

        String new_pass = "";
        
        for (int i = 0; i < 6; i++) {
            for (int j = 0; j < 5; j++) {
                new_pass += ans[i][j];
            }
        }
        
        return new_pass;
    }
}
