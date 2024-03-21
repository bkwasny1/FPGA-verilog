
with open('G:/Program Files/semestr6/Systemy rekonfigurowalne/lab2/note.txt', 'rb') as file:
    # Otwieramy plik do zapisu bitów w formie odwróconej
    with open('G:/Program Files/semestr6/Systemy rekonfigurowalne/lab2/note_python.txt', 'w') as output_file:
        #Odczytujemy bajty z pliku tekst.txt
        byte = file.read(1)
        output_file.write('0')
        while byte:
            output_file.write('1')
            number = ord(byte)
            bits = format(number, '08b')
            bits = bits[::-1]
            output_file.write(bits)
            print(bits)
            output_file.write('00')
            byte = file.read(1)

print("Operacja zakończona pomyślnie.")

