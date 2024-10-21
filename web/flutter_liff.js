async function initLiff(liffID) {
    await liff.init({
        liffId: liffID,
    });
}

async function getProfile() {
    const profile = await liff.getProfile();
    return profile["displayName"];
}

async function getIsGroup() {
    const group = await liff.getContext();
    if(group["type"] == "group") {
        return true;
    } else {
        return false;
    }
}