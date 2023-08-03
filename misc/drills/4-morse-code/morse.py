from manim import *

class MorseCode(Scene):
    def construct(self):
        code = {
            "D": "- . .",
            "E": ".",
            "Z": "- - . .",
            "N": "- .",
            "U": ". . -",
            "T": "-",
        }
        for letter, morse in code.items():
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
        circle = Circle(fill_opacity=1).scale(2)
        self.play(FadeIn(circle))
        self.wait(0.5)
        self.play(FadeOut(circle))
        self.wait(0.5)

    def play_flash_dash(self):
        circle = Circle(fill_opacity=1).scale(2)
        self.play(FadeIn(circle))
        self.wait(1.5)
        self.play(FadeOut(circle))
        self.wait(0.5)
