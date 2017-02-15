# Layout based on Kinesis Advantage

def main():
    shift_L = "SHIFT_L"
    shift_R = "SHIFT_R"

    # based on Kinesis Advantage

    chars_on_dvorak_left = """
    =12345
    ',.py
    aoeui
    ;qjkx
    `
    """

    chars_on_dvorak_right = r"""
    67890-
    fgcrl/
    dhtns\
    bmwvz
    []
    """

    keycodes_on_dvorak_left = char_list_to_keycodes(
        chars_to_list(
            chars_on_dvorak_left
        )
    )

    keycodes_on_dvorak_right = char_list_to_keycodes(
        chars_to_list(
            chars_on_dvorak_right
        )
    )

    disable_left_shift_with_left_side_keys = map(
        lambda keycode: disable(keycode, shift_L),
        keycodes_on_dvorak_left
    )

    disable_right_shift_with_right_side_keys = map(
        lambda keycode: disable(keycode, shift_R),
        keycodes_on_dvorak_right
    )

    print("<!-- AUTOGENERATED BEGIN -->")
    for d in disable_left_shift_with_left_side_keys + disable_right_shift_with_right_side_keys:
        print(d)
    print("<!-- AUTOGENERATED END -->")


def char_list_to_keycodes(char_list):
    def map_to_keycode(char):
        if char.isalpha():
            return map_char_to_keycode(char)
        elif char.isdigit():
            return "KEY_{}".format(char)
        else:
            return map_symbol_to_keycode(char)

    return map(map_to_keycode, char_list)

def chars_to_list(chars):
    return list(chars.replace('\n', '').replace(' ', ''))

def map_symbol_to_keycode(symbol):
    symbol_map_with_whitespace = {
        "`": "BACKQUOTE    ",
        "\\": "BACKSLASH    ",
        '[': "BRACKET_LEFT ",
        ']': "BRACKET_RIGHT",
        ',': "COMMA        ",
        '.': "DOT          ",
        '=': "EQUAL        ",
        '-': "MINUS        ",
        "'": "QUOTE        ",
        ';': "SEMICOLON    ",
        '/': "SLASH        ",
    }
    symbol_map = { k: v.strip() for (k, v) in symbol_map_with_whitespace.items() }

    return symbol_map[symbol]

def map_char_to_keycode(char):
    return char.capitalize()

def disable(key, modifer):
    identifier = "disable.{}-{}".format(modifer, key)
    name = "Disable {}-{}".format(modifer, key)
    disable_format = """
    <item>
        <identifier>{identifier}</identifier>
        <name>{name}</name>
        <autogen>
            __KeyToKey__
            KeyCode::{key}, ModifierFlag::{modifier},
            KeyCode::VK_NONE,
        </autogen>
    </item>
    """

    return disable_format.format(
        identifier=identifier,
        name=name,
        key=key,
        modifier=modifer
    )

if __name__ == '__main__':
    main()
