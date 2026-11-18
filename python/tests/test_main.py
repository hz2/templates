from python_template.__main__ import main


def test_main(capsys):
    assert main(["Ada"]) == 0
    assert capsys.readouterr().out == "Hello, Ada!\n"
