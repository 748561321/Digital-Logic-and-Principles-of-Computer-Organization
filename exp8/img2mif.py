from PIL import Image
height = 480
width = 640
ratio = width /height

def img2mif(filename):
     filepath = "./"+filename
     outpath="pic.mif"
     f=open(outpath, "w")
     f.write("--VGA Memory Map\n---Height: 480,Width: 640\n\nWIDTH=12;\nDEPTH=327680;\nADDRESS_RADIX=HEX;\nDATA_RADIX=HEX;\nCONTENT\nBEGIN\n")
     image=Image.open(filepath)
     image=image.crop((1,1,image.height*ratio,image.height))
     image=image.resize((width,height))
     image.save("new_"+filename)
     cnt = 0
     for c in range(0, image.width):
             for r in range(0,512):
                     cnt=cnt+1
                     if r < height:
                             R=image.getpixel((c,r))[0]
                             G=image.getpixel((c,r))[1]
                             B=image.getpixel((c,r))[2]
                     else:
                             R=15
                             G=15
                             B=15
                     f.write("{0:06x}: {1:x}{2:x}{3:x};\n".format(cnt-1, R>>4, G>>4, B>>4))
     f.write("END;")
     f.close()

