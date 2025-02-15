package com.wssys.test;
import java.awt.BorderLayout;  
import java.awt.Dimension;  
import java.awt.Image;  
import java.awt.event.ActionEvent;  
import java.awt.event.ActionListener;  
import java.util.ArrayList;  
import java.util.List;  
import java.util.concurrent.ExecutionException;  
  
import javax.imageio.ImageIO;  
import javax.swing.ImageIcon;  
import javax.swing.JButton;  
import javax.swing.JLabel;  
import javax.swing.JPanel;  
import javax.swing.JProgressBar;  
import javax.swing.JScrollPane;  
import javax.swing.SwingUtilities;  
import javax.swing.SwingWorker;

public class TestSwingWorker extends SwingWorker<List<Image>,String>{
	 private JLabel status;  
	    private JPanel viewer;  
	    private String[] imagesName;  
	    private JProgressBar jpb;  
	      
	    public static void main(String[] args) {  
	        SwingUtilities.invokeLater(new Runnable(){  
	            public void run() {  
	                TestFrame frame = new TestFrame();  
	                final JPanel panel = new JPanel();  
	                final JLabel label = new JLabel();  
	                  
	                final String[] imagesName = new String[38];  
	                for(int i=0; i<imagesName.length; i++){  
	                    imagesName[i] = "res/1 ("+(i+1)+").jpg";  
	                }  
	                  
	                JScrollPane sp = new JScrollPane(panel);  
	                sp.setSize(new Dimension(700,500));  
	                frame.add(sp,BorderLayout.CENTER);  
	                  
	                JPanel stp = new JPanel();  
	                final JProgressBar jpb = new JProgressBar();  
	                jpb.setMinimum(1);  
	                jpb.setMaximum(imagesName.length);  
	                stp.add(jpb);  
	                stp.add(label);  
	                frame.add(stp,BorderLayout.SOUTH);  
	                  
	                JButton button = new JButton("load image");  
	                button.addActionListener(new ActionListener(){  
	                    public void actionPerformed(ActionEvent e) {  
	                        TestSwingWorker sw = new TestSwingWorker(label, panel, imagesName, jpb);  
	                        sw.execute();  
	                    }  
	                });  
	  
	                frame.add(button,BorderLayout.NORTH);  
	                  
	                frame.setVisible(true);  
	            }  
	        });  
	    }  
	    
	    public TestSwingWorker(JLabel status, JPanel viewer, String[] imagesName, JProgressBar jpb){  
	        this.status = status;  
	        this.viewer = viewer;  
	        this.imagesName = imagesName;  
	        this.jpb = jpb;  
	    }  
	  
	    @Override  
	    protected List<Image> doInBackground() throws Exception {  
	        List<Image> image = new ArrayList<Image>();  
	        for(int i=0; i<imagesName.length; i++){  
	            image.add(ImageIO.read(getClass().getClassLoader().getResource(imagesName[i])));  
	            publish("已经加载了  "+(i+1)+"/"+imagesName.length+" : "+imagesName[i]);  
	        }  
	        return image;  
	    }  
	  
	    @Override  
	    protected void process(List<String> chunks) {  
	        status.setText(chunks.get(chunks.size()-1));  
	        int x = Integer.parseInt(chunks.get(chunks.size()-1).substring(chunks.get(chunks.size()-1).indexOf("(")+1,chunks.get(chunks.size()-1).indexOf(")")).trim());  
	        jpb.setValue(x);  
	          
	        for(String str : chunks){  
	            System.out.println(str);  
	        }  
	    }  
	  
	    @Override  
	    protected void done() {  
	        try {  
	            for(Image image : get()){  
	                JLabel label = new JLabel(new ImageIcon(image));  
	                label.setSize(160, 120);  
	                label.setPreferredSize(new Dimension(160,120));  
	                viewer.add(label);  
	            }  
	        } catch (InterruptedException e) {  
	            e.printStackTrace();  
	        } catch (ExecutionException e) {  
	            e.printStackTrace();  
	        }  
	    }  
}
