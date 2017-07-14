//
//  CommonDatePickView.m
//  EIntegrate
//
//  Created by xiaowei on 16/12/23.
//  Copyright © 2016年 CGL. All rights reserved.
//

#import "CommonDatePickView.h"

#define beginYear         1985 //起始年份 提供起始年份开始100年内的年份选择

#define Action_Tag_Cancel 100
#define Action_Tag_Ok     101

@interface CommonDatePickView ()
{
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    BOOL firstTimeLoad;
}
@end

@implementation CommonDatePickView


-(id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        yearMtbArray = [[NSMutableArray alloc]init];
        for (int i=beginYear; i<beginYear+1000; i++)
        {
            [yearMtbArray addObject:[NSNumber numberWithInt:i]];
        }
        monthMtbArray = [[NSMutableArray alloc]init];
        for (int i=1; i<13; i++)
        {
            [monthMtbArray addObject:[NSNumber numberWithInt:i]];
        }
        dayMtbArray = [[NSMutableArray alloc]init];
        for (int i = 1; i <= 31; i++)
        {
            [dayMtbArray addObject:[NSNumber numberWithInt:i]];
        }
        hourMtbArray = [[NSMutableArray alloc]init];
        for (int i=0; i<24; i++)
        {
            [hourMtbArray addObject:[NSNumber numberWithInt:i]];
        }
        minuteMtbArray = [[NSMutableArray alloc]init];
        for (int i = 0; i<60; i++) {
            [minuteMtbArray addObject:[NSNumber numberWithInt:i]];
        }
        self.pickerView.delegate = self;
        self.pickerView.dataSource =self;
        
        [self creatPickView];
    }
    return self;
    
}

-(void)creatPickView{

    _pickerView = [[UIPickerView alloc] initWithFrame:self.frame];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.centerX = kScreenWidth/2;
    NSLog(@"%@",NSStringFromCGRect(_pickerView.frame));
    
    [self addSubview:_pickerView];
    
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.centerX = kScreenWidth/2;
    [self addSubview:_datePicker];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    yearMtbArray = [[NSMutableArray alloc]init];
    for (int i=beginYear; i<beginYear+1000; i++)
    {
        [yearMtbArray addObject:[NSNumber numberWithInt:i]];
    }
    monthMtbArray = [[NSMutableArray alloc]init];
    for (int i=1; i<13; i++)
    {
        [monthMtbArray addObject:[NSNumber numberWithInt:i]];
    }
    dayMtbArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 31; i++)
    {
        [dayMtbArray addObject:[NSNumber numberWithInt:i]];
    }
    hourMtbArray = [[NSMutableArray alloc]init];
    for (int i=0; i<24; i++)
    {
        [hourMtbArray addObject:[NSNumber numberWithInt:i]];
    }
    for (int i = 0; i<60; i++) {
        [minuteMtbArray addObject:[NSNumber numberWithInt:i]];
    }
    self.pickerView.delegate = self;
    self.pickerView.dataSource =self;
   
//    [self creatVIewAndDate];
}

-(void)creatVIewAndDate{
    firstTimeLoad = YES;
    if(self.pageType == kDatePickerTypeFull) //年 月 日
    {
        self.pickerView.hidden = YES; //年月日 把自定义的隐藏 用系统的
        if(self.maxDate)
            self.datePicker.maximumDate = self.maxDate;
        if(self.minDate)
            self.datePicker.minimumDate = self.minDate;
        
        if (self.indexDate!= nil) //设置默认选中项
        {
            [self.datePicker setDate:[self getDateFromDateStr:self.indexDate] animated:NO];
        }
        
    }else if (self.pageType == kDatePickerTypeDate ){ //分割年 月 日
        
        self.datePicker.hidden = YES;
        if (self.indexDate !=nil)
        {
            NSArray *temArray = [self.indexDate componentsSeparatedByString:@"-"];
            if (temArray.count == 3)
            {
                self.currentYear = [temArray[0] intValue];
                self.currentMonth = [temArray[1] intValue];
                self.currentDay = [temArray[2] intValue];
            }
        }
        
        if (self.currentYear>=beginYear&&self.currentMonth>=1&&self.currentYear<(beginYear+100)&&self.currentMonth<=12&&self.currentDay>=1&&self.currentDay<=31&&self.currentDay>=1)
        {
            [self.pickerView selectRow:self.currentYear-beginYear inComponent:0 animated:NO];
            [self.pickerView selectRow:self.currentMonth-1 inComponent:1 animated:NO];
            [self.pickerView selectRow:self.currentDay-1 inComponent:2 animated:NO];
        }
        else
        {
            [self.pickerView selectRow:0 inComponent:0 animated:NO];
            [self.pickerView selectRow:0 inComponent:1 animated:NO];
            [self.pickerView selectRow:0 inComponent:2 animated:NO];
            
            self.currentYear = [yearMtbArray[0] intValue];
            self.currentMonth = [monthMtbArray[0] intValue];
            self.currentDay = [dayMtbArray[0] intValue];
        }
    }
    else if(self.pageType == kDatePickerTypeNoSecond)  //只有年、月时 分割取出年份和月份
    {
        self.datePicker.hidden = YES;
        if (self.indexDate !=nil)
        {
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"- :"];
            NSArray *temArray = [self.indexDate componentsSeparatedByCharactersInSet:set];
            if (temArray.count == 5)
            {
                self.currentYear = [temArray[0] intValue];
                self.currentMonth = [temArray[1] intValue];
                self.currentDay = [temArray[2] intValue];
                self.currentHour = [temArray[3] intValue];
                self.currentMinute = [temArray[4] intValue];
            }
        }
        
        if (self.currentYear>=beginYear&&self.currentMonth>=1&&self.currentYear<(beginYear+100)&&self.currentMonth<=12&&self.currentDay>=1&&self.currentDay<=31&&self.currentHour>=0&&self.currentHour<24&&self.currentMinute>=0&&self.currentMinute<60)
        {
            [self.pickerView selectRow:self.currentYear-beginYear inComponent:0 animated:NO];
            [self.pickerView selectRow:self.currentMonth-1 inComponent:1 animated:NO];
            [self.pickerView selectRow:self.currentDay-1 inComponent:2 animated:NO];
            [self.pickerView selectRow:self.currentHour inComponent:3 animated:NO];
            [self.pickerView selectRow:self.currentMinute inComponent:4 animated:NO];
        }
        else
        {
            [self.pickerView selectRow:0 inComponent:0 animated:NO];
            [self.pickerView selectRow:0 inComponent:1 animated:NO];
            [self.pickerView selectRow:0 inComponent:2 animated:NO];
            [self.pickerView selectRow:0 inComponent:3 animated:NO];
            [self.pickerView selectRow:0 inComponent:4 animated:NO];
            
            self.currentYear = [yearMtbArray[0] intValue];
            self.currentMonth = [monthMtbArray[0] intValue];
            self.currentDay = [dayMtbArray[0] intValue];
            self.currentHour = [hourMtbArray[0] intValue];
            self.currentMinute = [minuteMtbArray[0] intValue];
        }
    }
    else if(self.pageType == kDatePickerTypeTime)
    {
        self.datePicker.hidden = YES;
        if (self.indexDate !=nil)
        {
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"- :"];
            NSArray *temArray = [self.indexDate componentsSeparatedByCharactersInSet:set];
            if (temArray.count == 2)
            {
                self.currentHour = [temArray[0] intValue];
                self.currentMinute = [temArray[1] intValue];
            }
        }
        
        if (self.currentHour>=0&&self.currentHour<24&&self.currentMinute>=0&&self.currentMinute<60)
        {
            [self.pickerView selectRow:self.currentHour inComponent:0 animated:NO];
            [self.pickerView selectRow:self.currentMinute inComponent:1 animated:NO];
        }
        else
        {
            [self.pickerView selectRow:0 inComponent:0 animated:NO];
            [self.pickerView selectRow:0 inComponent:1 animated:NO];
            
            self.currentHour = [hourMtbArray[0] intValue];
            self.currentMinute = [minuteMtbArray[0] intValue];
        }
    }

}

- (NSDate*)getDateFromDateStr:(NSString*)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([dateStr rangeOfString:@"-"].location!=NSNotFound) {
        
        if (dateStr.length>10) {
            
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
        else
        {
            [formatter setDateFormat:@"yyyy-MM-dd"];
        }
    }
    else
    {
        if (dateStr.length>10) {
            
            [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        }
        else
        {
            [formatter setDateFormat:@"yyyy/MM/dd"];
        }
    }
    NSDate *date = [formatter  dateFromString:dateStr];
    date = [self convertDateToLocalTime:date];
    return date;
    
}

//转换时区 输入时间 输出＋8时间
-(NSDate *)convertDateToLocalTime:(NSDate *)forDate
{
    
    NSTimeZone *nowTimeZone = [NSTimeZone localTimeZone];
    
    NSInteger timeOffset = [nowTimeZone secondsFromGMTForDate:forDate];
    
    
    NSDate *newDate = [forDate dateByAddingTimeInterval:timeOffset];
    
    return newDate;
    
}


#pragma mark--UIPickViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pageType == kDatePickerTypeNoSecond)
    {
        return 5;
    }
    else if(self.pageType == kDatePickerTypeTime)
    {
        return 2;
    }
    else if(self.pageType == kDatePickerTypeDate)
    {
        return 3;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.pageType == kDatePickerTypeNoSecond)
    {
        if (component == 0 ) {
            return yearMtbArray.count;
            
        }else if (component == 1){
            return monthMtbArray.count;
            
        }else if (component == 2){
            if (firstTimeLoad)
            {
                if (_currentMonth == 1 || _currentMonth == 3 || _currentMonth == 5 || _currentMonth == 7 || _currentMonth == 8 || _currentMonth == 10 || _currentMonth == 12)
                {
                    return 31;
                }
                else if (_currentMonth == 2)
                {
                    if(((_currentYear %4==0)&&(_currentYear %100!=0))||(_currentYear %400==0)){
                        
                        return 29;
                    }
                    else
                    {
                        return 28; // or return 29
                    }
                }
                else
                {
                    return 30;
                }
            }
            else
            {
                if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
                {
                    return 31;
                }
                else if (selectedMonthRow == 1)
                {
                    int yearint = [[yearMtbArray objectAtIndex:selectedYearRow] intValue];
                    
                    if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                        
                        return 28;
                    }
                    else
                    {
                        return 29; // or return 29
                    }
                }
                else
                {
                    return 30;
                }
            }
            
        }else if (component == 3){
            return hourMtbArray.count;
        }else if (component == 4){
            return minuteMtbArray.count;
        }
    }
    else if(self.pageType == kDatePickerTypeTime)
    {
        if (component == 0 ) {
            return hourMtbArray.count;
            
        }else if (component == 1){
            return minuteMtbArray.count;
        }

    }
    else if(self.pageType == kDatePickerTypeDate)
    {
        if (component == 0 ) {
            return yearMtbArray.count;
            
        }else if (component == 1){
            return monthMtbArray.count;
            
        }else if (component == 2){
            if (firstTimeLoad)
            {
                if (_currentMonth == 1 || _currentMonth == 3 || _currentMonth == 5 || _currentMonth == 7 || _currentMonth == 8 || _currentMonth == 10 || _currentMonth == 12)
                {
                    return 31;
                }
                else if (_currentMonth == 2)
                {
                    if(((_currentYear %4==0)&&(_currentYear %100!=0))||(_currentYear %400==0)){
                        
                        return 29;
                    }
                    else
                    {
                        return 28; // or return 29
                    }
                }
                else
                {
                    return 30;
                }
            }
            else
            {
                if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
                {
                    return 31;
                }
                else if (selectedMonthRow == 1)
                {
                    int yearint = [[yearMtbArray objectAtIndex:selectedYearRow] intValue];
                    
                    if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                        
                        return 28;
                    }
                    else
                    {
                        return 29; // or return 29
                    }
                }
                else
                {
                    return 30;
                }
            }
            
        }
    }
    return 0;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.pageType == kDatePickerTypeNoSecond)
    {
        if (component == 0) {
            return 70;
        }else if (component ==1 || component == 2){
            return 40;
        }else{
            return 65;
        }
    }
    else if(self.pageType == kDatePickerTypeTime)
    {
        return 150;
    }
    else if(self.pageType == kDatePickerTypeDate)
    {
        return 100;
    }
    return 300;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pageType == kDatePickerTypeNoSecond)
    {
        if (component == 0)
        {
            return [NSString stringWithFormat:@"%@",yearMtbArray[row]];
        }
        else if (component == 1)
        {
            return [NSString stringWithFormat:@"%@",monthMtbArray[row]];
        }
        else if (component == 2)
        {
            return [NSString stringWithFormat:@"%@",dayMtbArray[row]];
        }else if (component == 3)
        {
            return [NSString stringWithFormat:@"%@时",hourMtbArray[row]];
        }
        else if (component == 4)
        {
            return [NSString stringWithFormat:@"%@分",minuteMtbArray[row]];
        }
    }
    else if(self.pageType == kDatePickerTypeTime)
    {
        if (component == 0)
        {
            return [NSString stringWithFormat:@"%@时",hourMtbArray[row]];
        }
        else if (component == 1)
        {
            return [NSString stringWithFormat:@"%@分",minuteMtbArray[row]];
        }
    }
    else if (self.pageType == kDatePickerTypeDate)
    {
        if (component == 0)
        {
            return [NSString stringWithFormat:@"%@",yearMtbArray[row]];
        }
        else if (component == 1)
        {
            return [NSString stringWithFormat:@"%@",monthMtbArray[row]];
        }
        else if (component == 2)
        {
            return [NSString stringWithFormat:@"%@",dayMtbArray[row]];
        }
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pageType == kDatePickerTypeNoSecond)
    {
        if (component == 0)
        {
            selectedYearRow = row;
            self.currentYear = [yearMtbArray[row] intValue];
            [self.pickerView reloadAllComponents];
        }
        else if (component == 1)
        {
            selectedMonthRow = row;
            self.currentMonth = [monthMtbArray[row] intValue];
            [self.pickerView reloadAllComponents];
            
        }else if (component == 2)
        {
            self.currentDay = [dayMtbArray[row] intValue];
            [self.pickerView reloadAllComponents];
        }else if (component == 3)
        {
            self.currentHour = [hourMtbArray[row] intValue];
        }
        else if (component == 4)
        {
            self.currentMinute = [minuteMtbArray[row] intValue];
        }
        [self.pickerView reloadAllComponents];
    }
    else if(self.pageType == kDatePickerTypeTime)
    {
        if (component == 0)
        {
            self.currentHour = [hourMtbArray[row] intValue];
        }
        else if (component == 1)
        {
            self.currentMinute = [minuteMtbArray[row] intValue];
        }
        [self.pickerView reloadAllComponents];
    }
    else if (self.pageType == kDatePickerTypeDate)
    {
        if (component == 0)
        {
            selectedYearRow = row;
            self.currentYear = [yearMtbArray[row] intValue];
            [self.pickerView reloadAllComponents];
        }
        else if (component == 1)
        {
            selectedMonthRow = row;
            self.currentMonth = [monthMtbArray[row] intValue];
            [self.pickerView reloadAllComponents];
            
        }else if (component == 2)
        {
            self.currentDay = [dayMtbArray[row] intValue];
            [self.pickerView reloadAllComponents];
        }
    }
    
    [self selectAction];
}

-(void)selectAction{
    if (self.pageType == kDatePickerTypeFull)
    {
        self.clickOkAction([self getDateStrWithDate:self.datePicker.date withCutStr:@"-" hasTime:NO]);
    }
    else if(self.pageType == kDatePickerTypeNoSecond)
    {
        if (self.currentMonth<10) //选择的月份小于10时 前面补个0
        {
            if (self.currentDay < 10 )
            {
                if (self.currentHour<10) {
                    if (self.currentMinute<10) {
                        self.clickOkAction([NSString stringWithFormat:@"%d-0%d-0%d 0%d:0%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }else{
                        self.clickOkAction([NSString stringWithFormat:@"%d-0%d-0%d 0%d:%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }
                }else{
                    if (self.currentMinute<10) {
                        self.clickOkAction([NSString stringWithFormat:@"%d-0%d-0%d %d:0%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }else{
                        self.clickOkAction([NSString stringWithFormat:@"%d-0%d-0%d %d:%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }
                }
            }
            else
            {
                if (self.currentHour<10) {
                    if (self.currentMinute<10) {
                        self.clickOkAction([NSString stringWithFormat:@"%d-0%d-%d 0%d:0%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }else{
                        self.clickOkAction([NSString stringWithFormat:@"%d-0%d-%d 0%d:%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }
                }else{
                    if (self.currentMinute<10) {
                        self.clickOkAction([NSString stringWithFormat:@"%d-0%d-%d %d:0%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }else{
                        self.clickOkAction([NSString stringWithFormat:@"%d-0%d-%d %d:%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }
                }
            }
        }
        else
        {
            if (self.currentDay < 10 )
            {
                if (self.currentHour<10) {
                    if (self.currentMinute<10) {
                        self.clickOkAction([NSString stringWithFormat:@"%d-%d-0%d 0%d:0%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }else{
                        self.clickOkAction([NSString stringWithFormat:@"%d-%d-0%d 0%d:%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }
                }else{
                    if (self.currentMinute<10) {
                        self.clickOkAction([NSString stringWithFormat:@"%d-%d-0%d %d:0%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }else{
                        self.clickOkAction([NSString stringWithFormat:@"%d-%d-0%d %d:%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }
                }
            }
            else
            {
                if (self.currentHour<10) {
                    if (self.currentMinute<10) {
                        self.clickOkAction([NSString stringWithFormat:@"%d-%d-%d 0%d:0%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }else{
                        self.clickOkAction([NSString stringWithFormat:@"%d-%d-%d 0%d:%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }
                }else{
                    if (self.currentMinute<10) {
                        self.clickOkAction([NSString stringWithFormat:@"%d-%d-%d %d:0%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }else{
                        self.clickOkAction([NSString stringWithFormat:@"%d-%d-%d %d:%d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinute]);
                    }
                }
            }
        }
    }
    else if(self.pageType == kDatePickerTypeTime)
    {
        if (self.currentHour<10) {
            if (self.currentMinute<10) {
                self.clickOkAction([NSString stringWithFormat:@"0%d:0%d",self.currentHour,self.currentMinute]);
            }else{
                self.clickOkAction([NSString stringWithFormat:@"0%d:%d",self.currentHour,self.currentMinute]);
            }
        }else{
            if (self.currentMinute<10) {
                self.clickOkAction([NSString stringWithFormat:@"%d:0%d",self.currentHour,self.currentMinute]);
            }else{
                self.clickOkAction([NSString stringWithFormat:@"%d:%d",self.currentHour,self.currentMinute]);
            }
        }
    }
    else if(self.pageType == kDatePickerTypeDate)  //yyyy%@MM%@dd HH:mm:ss
    {
        
        if (self.currentMonth<10) //选择的月份小于10时 前面补个0
        {
            if (self.currentDay < 10 )
            {
                self.clickOkAction([NSString stringWithFormat:@"%d-0%d-0%d",self.currentYear,self.currentMonth,self.currentDay]);
            }
            else
            {
                self.clickOkAction([NSString stringWithFormat:@"%d-0%d-%d",self.currentYear,self.currentMonth,self.currentDay]);
            }
        }
        else
        {
            if (self.currentDay < 10 )
            {
                self.clickOkAction([NSString stringWithFormat:@"%d-%d-0%d",self.currentYear,self.currentMonth,self.currentDay]);
            }
            else
            {
                self.clickOkAction([NSString stringWithFormat:@"%d-%d-%d",self.currentYear,self.currentMonth,self.currentDay]);
            }
        }
    }
}

/**
 *	@brief	获取指定日期的字符串表达式 需要当前日期时传入：[NSDate date] 即可 注意时区转换
 *
 *	@param 	someDate 	指定的日期 NSDate类型
 *	@param 	cutStr 	分割线类型 @"/" 或者@“-”  传nil时默认使用@“-”
 *  @param  hasTime     是否需要返回时间
 *	@return	返回的日期字符串  格式为 2012-13-23 或者 2013/13/23 或2012-12-12 12:11:11 或2102/12/12 12:12:12
 */
- (NSString *)getDateStrWithDate:(NSDate*)someDate withCutStr:(NSString*)cutStr hasTime:(BOOL)hasTime
{
    if (cutStr == nil) {
        cutStr = @"-";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *str = nil;
    if (hasTime) {
        str = [NSString stringWithFormat:@"yyyy%@MM%@dd HH:mm:ss",cutStr,cutStr];
    }
    else
    {
        str = [NSString stringWithFormat:@"yyyy%@MM%@dd",cutStr,cutStr];
    }
    [formatter setDateFormat:str];
    NSString *date = [formatter stringFromDate:someDate];
    return date;
}



@end
