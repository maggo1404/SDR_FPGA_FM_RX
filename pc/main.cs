using System;
using System.IO.Ports;
using System.Media;

class SerialToSound
{
    static void Main()
    {
        // Öffnen der seriellen Schnittstelle
        SerialPort port = new SerialPort("COM1", 9600, Parity.None, 8, StopBits.One);
        port.Open();

        // Erstellen des SoundPlayers
        SoundPlayer player = new SoundPlayer();

        while (true)
        {
            // Lesen eines Bytes von der seriellen Schnittstelle
            byte b = (byte)port.ReadByte();

            // Konvertieren des Bytes in eine Frequenz (z.B. von 0-255 auf 200-2000 Hz)
            int frequency = (int)(b * 7.84 + 200);

            // Generieren eines Sinus-Tons mit der Frequenz für 100 Millisekunden
            byte[] sin = new byte[44100 * 2];
            int sampleRate = 44100;
            double amplitude = 0.25;
            for (int i = 0; i < sin.Length / 2; i++)
            {
                double time = (double)i / (double)sampleRate;
                double raw = Math.Sin(2 * Math.PI * frequency * time);
                short sample = (short)(raw * amplitude * short.MaxValue);
                BitConverter.GetBytes(sample).CopyTo(sin, i * 2);
            }

            // Laden des Sinus-Tons in den SoundPlayer
            player.Stream = new System.IO.MemoryStream(sin);

            // Abspielen des Tons
            player.Play();
        }
    }
}
