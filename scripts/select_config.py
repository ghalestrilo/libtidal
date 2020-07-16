#!/usr/bin/env python3

from simple_term_menu import TerminalMenu


def main():
  terminal_menu = TerminalMenu(["entry 1", "entry 2", "entry 3"])
  terminal_menu.show()


if __name__ == "__main__":
  main()

