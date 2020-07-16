import os
from bullet import Bullet
from bullet import colors

def list_files(directory="."):
  return (file for file in os.listdir(directory)
    if os.path.isfile(os.path.join(directory, file))
    and file.endswith(".conf.yaml"))

def main():
  cli = Bullet(
    prompt = "\nPlease choose a demo: ",
    choices = list(list_files()),
    indent = 0,
    align = 5,
    margin = 2,
    bullet = ">",
    # bullet_color=colors.bright(colors.foreground["red"]),
    # word_color=colors.bright(colors.foreground["yellow"]),
	  # word_on_switch=colors.bright(colors.foreground["green"]),
    # background_color=colors.background["black"],
    # background_on_switch=colors.background["black"],
	  pad_right = 2
  )
  result = cli.launch()
  return result

if __name__ == "__main__":
  main()

