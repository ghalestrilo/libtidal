#!/usr/bin/env python3
import os
from simple_term_menu import TerminalMenu

def list_files(directory="."):
  return (file for file in os.listdir(directory)
    if os.path.isfile(os.path.join(directory, file))
    and file.endswith(".conf.yaml"))

def main():
  print("Select config:")
  terminal_menu = TerminalMenu(list_files(), preview_size=0.75)
  terminal_menu.show()


if __name__ == "__main__":
  main()
