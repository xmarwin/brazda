export type starRatingSizes = "small" | "medium" | "large";
export type starRatingColors = "default" | "negative" | "ok" | "positive";
export type starRatingSpeed = "immediately" | "noticeable" | "slow";
export type starRatingPosition = "left" | "right" | "top" | "bottom";
export type starRatingStarTypes = "svg" | "icon" | "image";
export type starRatingStarSpace= "no" | "between" | "around";

export interface IStarRatingCompBindings {
    //Inputs (< bindings)
    id?: string;
    labelText?: string;
    staticColor?: starRatingColors;
    labelPosition?: starRatingPosition;
    speed?: starRatingSpeed;
    size?: starRatingSizes;
    starType?: starRatingStarTypes;
    space?: starRatingStarSpace;
    readOnly?: boolean;
    disabled?: boolean;
    showHalfStars?: boolean;
    labelHidden?: boolean;
    showHoverStars?: boolean;
    rating?: number;
    numOfStars?: number;
    getHalfStarVisible?(rating: number): boolean;
    getColor?(rating: number, numOfStars: number, staticColor?: starRatingColors): starRatingColors;
    //Outputs (& bindings)
    onHover?: ($event: any) =>  any;
    onClick?: ($event: any) =>  any;
    onRatingChange?: ($event: any) => any;
}


export interface IStarRatingOnHoverEvent {
    hoverRating: number;
}
export interface IStarRatingOnClickEvent {
    rating: number;
}
export interface IStarRatingOnUpdateEvent {
    rating: number;
}