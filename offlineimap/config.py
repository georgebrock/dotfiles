import onepassword
from getpass import getpass

FOLDER_MAP = {
    "drafts":  "[Gmail]/Drafts",
    "sent":    "[Gmail]/Sent Mail",
    "flagged": "[Gmail]/Starred",
    "trash":   "[Gmail]/Trash",
    "archive": "[Gmail]/All Mail"
}

INVERSE_FOLDER_MAP = {v:k for k,v in FOLDER_MAP.items()}

EXCLUDED_FOLDERS = ["[Gmail]/Trash", "[Gmail]/Important", "[Gmail]/Spam"]

def local_folder_to_gmail_folder(folder):
    return FOLDER_MAP.get(folder, folder)

def gmail_folder_to_local_folder(folder):
    return INVERSE_FOLDER_MAP.get(folder, folder)

def should_include_folder(folder):
    return folder not in EXCLUDED_FOLDERS

def get_password(name):
    keychain = onepassword.Keychain("~/Dropbox/1Password.agilekeychain")
    while keychain.locked:
        keychain.unlock(getpass("1Password: "))
    return keychain.item(name).password
