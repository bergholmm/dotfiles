if test "$(uname)" = "Darwin"
then
  ./macos/install.bash
else
  ./linux/install.bash
fi

exit 0
