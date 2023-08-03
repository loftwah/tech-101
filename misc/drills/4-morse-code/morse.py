from manim import *

MORSE_CODE_DICT = { 'A':'.-', 'B':'-...',
                    'C':'-.-.', 'D':'-..', 'E':'.',
                    'F':'..-.', 'G':'--.', 'H':'....',
                    'I':'..', 'J':'.---', 'K':'-.-',
                    'L':'.-..', 'M':'--', 'N':'-.',
                    'O':'---', 'P':'.--.', 'Q':'--.-',
                    'R':'.-.', 'S':'...', 'T':'-',
                    'U':'..-', 'V':'...-', 'W':'.--',
                    'X':'-..-', 'Y':'-.--', 'Z':'--..'}

class MorseCode(Scene):
    def construct(self):
        # Read word from file
        with open('word.txt', 'r') as file:
            word = file.read().strip().upper()

        # Convert word to Morse code using the MORSE_CODE_DICT
        code = [(letter, MORSE_CODE_DICT[letter]) for letter in word if letter in MORSE_CODE_DICT]

        # Animate each letter
        for letter, morse in code:
            self.play_flash(letter, morse)

    def play_flash(self, letter, morse):
        # Show letter
        text = Text(letter).scale(2)
        self.play(Write(text))
        self.wait(1)
        self.play(FadeOut(text))

        # Show Morse code
        for symbol in morse.split(" "):
            if symbol == ".":
                self.play_flash_dot()
            elif symbol == "-":
                self.play_flash_dash()

        self.wait(2)

    def play_flash_dot(self):
        circle = Circle(fill_opacity=1).scale(1)
        self.play(FadeIn(circle))
        self.wait(0.3)
        self.play(FadeOut(circle))
        self.wait(0.3)

    def play_flash_dash(self):
        circle = Circle(fill_opacity=1).scale(1)
        self.play(FadeIn(circle))
        self.wait(0.6)
        self.play(FadeOut(circle))
        self.wait(0.3)
