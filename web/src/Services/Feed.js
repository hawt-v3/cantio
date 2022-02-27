import { ENDPOINT } from "../../Misc/constants";

export const getFeed = async userId => {
  let res = await fetch(`${ENDPOINT}/feed?uid=${userId}`, {
    mode: "cors",
  });
  res = await res.json();
  return res;
};

export const getBrowse = async userId => {
  let res = await fetch(`${ENDPOINT}/browse?uid=${userId}`, {
    mode: "cors",
  });
  res = await res.json();
  return res;
};
