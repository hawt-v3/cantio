import { ENDPOINT } from "../../Misc/constants";

export const getFeed = async userId => {
  let res = await fetch(`${ENDPOINT}/feed?uid=${userId}`);
  res = await res.json();
  return res;
};
