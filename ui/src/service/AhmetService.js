import { AHMET_API } from '@/config';
import api from "./api";


export const  AhmetService = {
    getTreeTableNodes(parentID) {
        let param = parentID ? String(parentID) : ""
        return api.get("/getlegacies/" +param, {baseURL:AHMET_API});
    },
    getFile(fileID) {
        window.location.href = AHMET_API + "/legacy/download/" + fileID
        console.log(fileID)
    }
}