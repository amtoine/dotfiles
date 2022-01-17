#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                              _____             __         __  _ __           __             _
#            _________  ____  / __(_)___ _     _/_/  ____ _/ /_(_) /__       _/_/  ____ ___  (_)_________         ____  __  __
#           / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / __ `/ __/ / / _ \    _/_/   / __ `__ \/ / ___/ ___/        / __ \/ / / /
#      _   / /__/ /_/ / / / / __/ / /_/ /  _/_/    / /_/ / /_/ / /  __/  _/_/    / / / / / / (__  ) /__    _    / /_/ / /_/ /
#     (_)  \___/\____/_/ /_/_/ /_/\__, /  /_/      \__, /\__/_/_/\___/  /_/     /_/ /_/ /_/_/____/\___/   (_)  / .___/\__, /
#                                /____/              /_/                                                      /_/    /____/
#
# Description:  TODO
# Dependencies: TODO
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# if __name__ in ["config", "__main__"]:
#     screens = init_screens()
#     widgets_list = init_widgets_list()
#     widgets_screen1 = init_widgets_screen1()
#     widgets_screen2 = init_widgets_screen2()
#
# def window_to_prev_group(qtile):
#     if qtile.currentwindow is not none:
#         i = qtile.groups.index(qtile.currentgroup)
#         qtile.currentwindow.togroup(qtile.groups[i - 1].name)
#
# def window_to_next_group(qtile):
#     if qtile.currentwindow is not none:
#         i = qtile.groups.index(qtile.currentgroup)
#         qtile.currentwindow.togroup(qtile.groups[i + 1].name)
#
# def window_to_previous_screen(qtile):
#     i = qtile.screens.index(qtile.current_screen)
#     if i != 0:
#         group = qtile.screens[i - 1].group.name
#         qtile.current_window.togroup(group)
#
# def window_to_next_screen(qtile):
#     i = qtile.screens.index(qtile.current_screen)
#     if i + 1 != len(qtile.screens):
#         group = qtile.screens[i + 1].group.name
#         qtile.current_window.togroup(group)
#
# def switch_screens(qtile):
#     i = qtile.screens.index(qtile.current_screen)
#     group = qtile.screens[i - 1].group
#     qtile.current_screen.set_group(group)
