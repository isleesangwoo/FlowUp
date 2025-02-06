$(document).ready(()=>{

    // ========== 시간을 알려주는 메소드 ========== //
    function updateClock() {
        const now = new Date();
        const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
        const dayOfWeek = daysOfWeek[now.getDay()];
        const year = now.getFullYear();
        const month = (now.getMonth() + 1).toString().padStart(2, '0');
        const day = now.getDate().toString().padStart(2, '0');
        const hours = now.getHours();
        const minutes = now.getMinutes().toString().padStart(2, '0');
        const seconds = now.getSeconds().toString().padStart(2, '0');
        
        let displayHours = hours;
        
        const timeString = `${year}-${month}-${day} (${dayOfWeek}) ${displayHours}:${minutes}:${seconds}`;
        document.getElementById('clock').textContent = timeString;
    }
    
    // 매 초마다 시계 업데이트
    setInterval(updateClock, 1000);
    
    // 페이지 로드 시에도 시계 업데이트
    updateClock();
    // ========== 시간을 알려주는 메소드 ========== //
});