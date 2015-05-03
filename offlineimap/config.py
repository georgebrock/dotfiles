import subprocess

FOLDER_MAP = {
    "drafts":  "[Gmail]/Drafts",
    "sent":    "[Gmail]/Sent Mail",
    "flagged": "[Gmail]/Starred",
    "trash":   "[Gmail]/Trash",
    "archive": "[Gmail]/All Mail"
}

INVERSE_FOLDER_MAP = {v:k for k,v in FOLDER_MAP.items()}

INCLUDED_FOLDERS = ["INBOX"] + FOLDER_MAP.values()

def local_folder_to_gmail_folder(folder):
    return FOLDER_MAP.get(folder, folder)

def gmail_folder_to_local_folder(folder):
    return INVERSE_FOLDER_MAP.get(folder, folder)

def should_include_folder(folder):
    return folder in INCLUDED_FOLDERS

def get_password(name):
    try:
        output = subprocess.check_output(["pass", name])
        return output.split("\n")[0]
    except subprocess.CalledProcessError:
        return None
